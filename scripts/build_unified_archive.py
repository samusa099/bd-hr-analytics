#!/usr/bin/env python3
"""Build one clean unified GitHub/Kaggle distribution archive."""

from __future__ import annotations

import fnmatch
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
OUTPUT = REPO_ROOT / "bd-hr-analytics-unified-project.zip"
ARCHIVE_ROOT = "bd-hr-analytics"

EXCLUDED_DIRS = {
    ".git",
    ".github",
    "releases",
    ".venv",
    "venv",
    "__pycache__",
    ".ipynb_checkpoints",
    ".pytest_cache",
    ".mypy_cache",
}

EXCLUDED_FILES = {
    OUTPUT.name,
    ".DS_Store",
    "Thumbs.db",
}

EXCLUDED_PATTERNS = (
    "*.pyc",
    "*.pyo",
    "*.tmp",
    "*.bak",
    "*~",
)


def should_include(path: Path) -> bool:
    relative = path.relative_to(REPO_ROOT)

    if any(part in EXCLUDED_DIRS for part in relative.parts):
        return False
    if path.name in EXCLUDED_FILES:
        return False
    if any(fnmatch.fnmatch(path.name, pattern) for pattern in EXCLUDED_PATTERNS):
        return False
    if path.is_symlink():
        return False
    return path.is_file()


def main() -> None:
    candidates = sorted(
        path for path in REPO_ROOT.rglob("*")
        if should_include(path)
    )

    if not candidates:
        raise RuntimeError("No project files found for the unified archive.")

    if OUTPUT.exists():
        OUTPUT.unlink()

    with zipfile.ZipFile(OUTPUT, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in candidates:
            relative = path.relative_to(REPO_ROOT)
            archive.write(path, Path(ARCHIVE_ROOT) / relative)

    with zipfile.ZipFile(OUTPUT, "r") as archive:
        bad_file = archive.testzip()
        if bad_file is not None:
            raise RuntimeError(f"Archive integrity check failed at: {bad_file}")
        names = archive.namelist()

    required = {
        f"{ARCHIVE_ROOT}/README.md",
        f"{ARCHIVE_ROOT}/data/csv/employees.csv",
        f"{ARCHIVE_ROOT}/sql/README.md",
        f"{ARCHIVE_ROOT}/docs/ETHICS_AND_LIMITATIONS.md",
        f"{ARCHIVE_ROOT}/assets/cover/bd_hr_analytics_cover.svg",
    }
    missing = sorted(required.difference(names))
    if missing:
        raise RuntimeError(f"Archive is missing required files: {missing}")

    print(f"PASS: created {OUTPUT.name}")
    print(f"  files packaged: {len(names)}")
    print(f"  archive size: {OUTPUT.stat().st_size / (1024 * 1024):.2f} MB")
    print("  excluded: .github, releases, caches, temporary files and duplicate archives")


if __name__ == "__main__":
    main()
