#!/usr/bin/env python3
"""Build the synthetic BD HR Analytics SQLite database from repository CSV files."""

from __future__ import annotations

import csv
import sqlite3
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
CSV_DIR = REPO_ROOT / "data" / "csv"
SQL_DIR = REPO_ROOT / "sql" / "sqlite"
DATABASE_DIR = REPO_ROOT / "database"
DATABASE_PATH = DATABASE_DIR / "bd_hr_analytics.sqlite"

IMPORT_MAP = {
    "employees.csv": "raw_employees",
    "recruitment.csv": "raw_recruitment",
    "learning.csv": "raw_learning",
    "monthly_hr_kpis.csv": "raw_monthly_hr_kpis",
    "department_monthly_kpis.csv": "raw_department_monthly_kpis",
    "department_scorecard.csv": "raw_department_scorecard",
    "intervention_impact.csv": "raw_intervention_impact",
    "data_dictionary.csv": "raw_data_dictionary",
}


def execute_sql_file(connection: sqlite3.Connection, path: Path) -> None:
    if not path.exists():
        raise FileNotFoundError(f"Required SQL file not found: {path}")
    connection.executescript(path.read_text(encoding="utf-8"))


def load_csv(connection: sqlite3.Connection, csv_path: Path, table_name: str) -> int:
    if not csv_path.exists():
        raise FileNotFoundError(f"Required CSV file not found: {csv_path}")

    with csv_path.open("r", encoding="utf-8-sig", newline="") as handle:
        reader = csv.DictReader(handle)
        if not reader.fieldnames:
            raise ValueError(f"CSV has no header: {csv_path}")

        columns = [column.strip() for column in reader.fieldnames]
        placeholders = ", ".join("?" for _ in columns)
        column_sql = ", ".join(f'"{column}"' for column in columns)
        insert_sql = f'INSERT INTO "{table_name}" ({column_sql}) VALUES ({placeholders})'

        rows = [tuple((row.get(column) or "").strip() for column in columns) for row in reader]
        connection.executemany(insert_sql, rows)
        return len(rows)


def main() -> None:
    DATABASE_DIR.mkdir(parents=True, exist_ok=True)
    if DATABASE_PATH.exists():
        DATABASE_PATH.unlink()

    with sqlite3.connect(DATABASE_PATH) as connection:
        connection.execute("PRAGMA foreign_keys = ON")
        execute_sql_file(connection, SQL_DIR / "01_create_schema.sql")

        loaded_counts: dict[str, int] = {}
        for csv_name, table_name in IMPORT_MAP.items():
            loaded_counts[csv_name] = load_csv(connection, CSV_DIR / csv_name, table_name)

        execute_sql_file(connection, SQL_DIR / "02_data_cleaning.sql")
        execute_sql_file(connection, SQL_DIR / "03_analytics_views.sql")

        integrity_result = connection.execute("PRAGMA integrity_check").fetchone()
        if not integrity_result or integrity_result[0] != "ok":
            raise RuntimeError(f"SQLite integrity check failed: {integrity_result}")

        issue_count = connection.execute(
            "SELECT COUNT(*) FROM data_quality_issues"
        ).fetchone()[0]
        connection.commit()

    print(f"PASS: database created at {DATABASE_PATH}")
    for csv_name, row_count in loaded_counts.items():
        print(f"  {csv_name}: {row_count} rows loaded")
    print(f"  data-quality issues logged: {issue_count}")
    print("  integrity_check: ok")
    print("NOTE: All records are synthetic; employee-risk outputs require human review.")


if __name__ == "__main__":
    main()
