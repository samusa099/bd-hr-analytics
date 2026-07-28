#!/usr/bin/env python3
"""Fail CI when repository data files violate basic safety policies.

This validator performs static inspection only. It never executes notebooks,
macros, formulas, or embedded content.
"""

from __future__ import annotations

import csv
import json
import math
import os
import re
import sys
import zipfile
from pathlib import Path, PurePosixPath
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]
MAX_FILE_BYTES = 100 * 1024 * 1024
MAX_NOTEBOOK_BYTES = 10 * 1024 * 1024
MAX_CELL_CHARS = 200_000
MAX_ARCHIVE_MEMBER_BYTES = 200 * 1024 * 1024
MAX_ARCHIVE_TOTAL_BYTES = 500 * 1024 * 1024
MAX_COMPRESSION_RATIO = 200

SKIP_DIRS = {".git", ".venv", "venv", "node_modules", "__pycache__"}
DANGEROUS_NOTEBOOK_PATTERNS = [
    re.compile(r"(^|\n)\s*!", re.MULTILINE),
    re.compile(r"(^|\n)\s*%(?:system|bash|sh|script|pip|conda)\b", re.IGNORECASE),
    re.compile(r"\b(?:os\.system|subprocess\.|eval\s*\(|exec\s*\()"),
]
FORMULA_PREFIXES = ("=", "+", "@")


class ValidationError(Exception):
    pass


def iter_files() -> Iterable[Path]:
    for path in ROOT.rglob("*"):
        if any(part in SKIP_DIRS for part in path.relative_to(ROOT).parts):
            continue
        if path.is_file() or path.is_symlink():
            yield path


def validate_containment(path: Path) -> None:
    relative = path.relative_to(ROOT)
    if path.is_symlink():
        target = path.resolve(strict=False)
        try:
            target.relative_to(ROOT)
        except ValueError as exc:
            raise ValidationError(f"Symlink escapes repository: {relative} -> {target}") from exc
    resolved = path.resolve(strict=False)
    try:
        resolved.relative_to(ROOT)
    except ValueError as exc:
        raise ValidationError(f"Path escapes repository root: {relative}") from exc
    if path.stat().st_size > MAX_FILE_BYTES:
        raise ValidationError(f"File exceeds 100 MiB policy: {relative}")


def safe_archive_name(name: str) -> bool:
    normalized = name.replace("\\", "/")
    candidate = PurePosixPath(normalized)
    return not (
        candidate.is_absolute()
        or ".." in candidate.parts
        or normalized.startswith("/")
        or re.match(r"^[A-Za-z]:", normalized)
    )


def validate_xlsx(path: Path) -> None:
    try:
        with zipfile.ZipFile(path) as archive:
            names = set(archive.namelist())
            required = {"[Content_Types].xml", "_rels/.rels", "xl/workbook.xml"}
            missing = required - names
            if missing:
                raise ValidationError(f"Invalid XLSX structure in {path.relative_to(ROOT)}; missing {sorted(missing)}")

            total_uncompressed = 0
            for member in archive.infolist():
                if not safe_archive_name(member.filename):
                    raise ValidationError(
                        f"Unsafe XLSX member path in {path.relative_to(ROOT)}: {member.filename}"
                    )
                if member.flag_bits & 0x1:
                    raise ValidationError(f"Encrypted XLSX member is not allowed: {path.relative_to(ROOT)}")
                if member.file_size > MAX_ARCHIVE_MEMBER_BYTES:
                    raise ValidationError(f"Oversized XLSX member in {path.relative_to(ROOT)}: {member.filename}")
                total_uncompressed += member.file_size
                compressed = max(member.compress_size, 1)
                if member.file_size / compressed > MAX_COMPRESSION_RATIO:
                    raise ValidationError(
                        f"Suspicious XLSX compression ratio in {path.relative_to(ROOT)}: {member.filename}"
                    )
            if total_uncompressed > MAX_ARCHIVE_TOTAL_BYTES:
                raise ValidationError(f"Expanded XLSX exceeds safety limit: {path.relative_to(ROOT)}")
            if "xl/vbaProject.bin" in names:
                raise ValidationError(f"Macro-enabled content detected in XLSX: {path.relative_to(ROOT)}")
            if any(name.startswith("xl/externalLinks/") for name in names):
                raise ValidationError(f"External workbook links detected: {path.relative_to(ROOT)}")
    except zipfile.BadZipFile as exc:
        raise ValidationError(f"Corrupt XLSX archive: {path.relative_to(ROOT)}") from exc


def validate_notebook(path: Path) -> None:
    relative = path.relative_to(ROOT)
    if path.stat().st_size > MAX_NOTEBOOK_BYTES:
        raise ValidationError(f"Notebook exceeds 10 MiB policy: {relative}")
    try:
        notebook = json.loads(path.read_text(encoding="utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise ValidationError(f"Notebook is not valid UTF-8 JSON: {relative}") from exc

    if notebook.get("nbformat") not in {4}:
        raise ValidationError(f"Notebook must use nbformat 4: {relative}")
    cells = notebook.get("cells")
    if not isinstance(cells, list):
        raise ValidationError(f"Notebook cells must be a list: {relative}")

    for index, cell in enumerate(cells):
        if not isinstance(cell, dict):
            raise ValidationError(f"Malformed notebook cell {index}: {relative}")
        source = cell.get("source", "")
        source_text = "".join(source) if isinstance(source, list) else str(source)
        if len(source_text) > MAX_CELL_CHARS:
            raise ValidationError(f"Notebook cell {index} is oversized: {relative}")
        if cell.get("cell_type") == "code":
            if cell.get("execution_count") is not None:
                raise ValidationError(f"Notebook must be committed unexecuted; cell {index}: {relative}")
            if cell.get("outputs") not in ([], None):
                raise ValidationError(f"Notebook outputs must be cleared; cell {index}: {relative}")
            for pattern in DANGEROUS_NOTEBOOK_PATTERNS:
                if pattern.search(source_text):
                    raise ValidationError(
                        f"Notebook contains disallowed execution pattern in cell {index}: {relative}"
                    )


def looks_like_negative_number(value: str) -> bool:
    return bool(re.fullmatch(r"-\s*(?:\d+(?:\.\d+)?|\.\d+)(?:[eE][+-]?\d+)?", value))


def validate_csv(path: Path) -> None:
    relative = path.relative_to(ROOT)
    try:
        with path.open("r", encoding="utf-8-sig", newline="") as handle:
            sample = handle.read(8192)
            handle.seek(0)
            try:
                dialect = csv.Sniffer().sniff(sample, delimiters=",;\t|")
            except csv.Error:
                dialect = csv.excel
            reader = csv.reader(handle, dialect)
            for row_number, row in enumerate(reader, start=1):
                for column_number, value in enumerate(row, start=1):
                    stripped = value.lstrip(" \t\r\n")
                    if not stripped:
                        continue
                    dangerous = stripped.startswith(FORMULA_PREFIXES) or (
                        stripped.startswith("-") and not looks_like_negative_number(stripped)
                    )
                    if dangerous:
                        preview = stripped[:40].replace("\n", " ")
                        raise ValidationError(
                            f"CSV formula-injection risk in {relative} at row {row_number}, "
                            f"column {column_number}: {preview!r}"
                        )
    except UnicodeDecodeError as exc:
        raise ValidationError(f"CSV must be UTF-8 encoded: {relative}") from exc
    except csv.Error as exc:
        raise ValidationError(f"Malformed CSV file: {relative}: {exc}") from exc


def main() -> int:
    errors: list[str] = []
    checked = {"paths": 0, "xlsx": 0, "notebooks": 0, "csv": 0}

    for path in iter_files():
        try:
            validate_containment(path)
            checked["paths"] += 1
            suffix = path.suffix.lower()
            if suffix == ".xlsx":
                validate_xlsx(path)
                checked["xlsx"] += 1
            elif suffix == ".ipynb":
                validate_notebook(path)
                checked["notebooks"] += 1
            elif suffix == ".csv":
                validate_csv(path)
                checked["csv"] += 1
        except (OSError, ValidationError) as exc:
            errors.append(str(exc))

    print("Validation summary:", ", ".join(f"{key}={value}" for key, value in checked.items()))
    if errors:
        print("\nSecurity validation failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    print("All repository security validations passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
