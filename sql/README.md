# 🗄️ SQL & SQLite Practice Suite

<p align="center">
  <strong>Run the synthetic HR analytics workflow in DBeaver or SQLite without changing the source CSV files.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Database-SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite" />
  <img src="https://img.shields.io/badge/Client-DBeaver-382923?style=for-the-badge" alt="DBeaver" />
  <img src="https://img.shields.io/badge/Workflow-Raw%20%E2%86%92%20Clean%20%E2%86%92%20BI--ready-14B8A6?style=for-the-badge" alt="Layered workflow" />
  <img src="https://img.shields.io/badge/Data-Synthetic-F97316?style=for-the-badge" alt="Synthetic data" />
</p>

## Folder contents

| File | Purpose |
|---|---|
| [`sqlite/01_create_schema.sql`](sqlite/01_create_schema.sql) | Creates load-friendly `raw_*` tables |
| [`sqlite/02_data_cleaning.sql`](sqlite/02_data_cleaning.sql) | Builds validated `clean_*` tables and a data-quality issue log |
| [`sqlite/03_analytics_views.sql`](sqlite/03_analytics_views.sql) | Creates BI-ready aggregate views |
| [`sqlite/04_portfolio_queries.sql`](sqlite/04_portfolio_queries.sql) | Provides reusable workforce, recruitment, learning and strategy queries |
| [`../scripts/build_sqlite_database.py`](../scripts/build_sqlite_database.py) | Optional one-command database builder |

## Run in DBeaver

1. Install DBeaver Community and ensure the SQLite driver is available.
2. Create a new **SQLite** connection.
3. Choose a database path such as:

```text
database/bd_hr_analytics.sqlite
```

4. Open and execute `sqlite/01_create_schema.sql`.
5. Import each file from `data/csv/` into its matching raw table:

| CSV | Destination table |
|---|---|
| `employees.csv` | `raw_employees` |
| `recruitment.csv` | `raw_recruitment` |
| `learning.csv` | `raw_learning` |
| `monthly_hr_kpis.csv` | `raw_monthly_hr_kpis` |
| `department_monthly_kpis.csv` | `raw_department_monthly_kpis` |
| `department_scorecard.csv` | `raw_department_scorecard` |
| `intervention_impact.csv` | `raw_intervention_impact` |
| `data_dictionary.csv` | `raw_data_dictionary` |

In DBeaver, right-click the destination table and select **Import Data → CSV**. Map CSV headers to matching columns and leave `_source_row_id` unmapped.

6. Execute `sqlite/02_data_cleaning.sql`.
7. Execute `sqlite/03_analytics_views.sql`.
8. Run selected statements from `sqlite/04_portfolio_queries.sql`.
9. Review `vw_data_quality_summary` before using the results in a dashboard.

## Automated local build

From the repository root:

```bash
python scripts/build_sqlite_database.py
```

The script recreates:

```text
database/bd_hr_analytics.sqlite
```

It loads the central CSV files, executes the cleaning workflow, creates analytics views and runs SQLite integrity checks.

## Cleaning principles

- Raw tables remain unchanged.
- Duplicate business keys are resolved only in the clean layer.
- Invalid dates or ranges become `NULL` and are logged for review.
- Percentage fields are expected as decimals between `0` and `1`.
- Employee-risk output is aggregated for portfolio analysis.
- No query authorises automated hiring, termination, promotion or disciplinary decisions.

## Recommended practice levels

**Beginner:** run the supplied analysis queries and export results.

**Intermediate:** add new data-quality rules and department-level views.

**Advanced:** create a star schema, test indexes, document query plans and connect the BI-ready views to Power BI.
