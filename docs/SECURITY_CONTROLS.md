# 🔐 Repository Security Controls

This portfolio repository treats datasets, spreadsheets, notebooks, source code, and automation files as untrusted until validated.

## Automated controls

| Control | Purpose |
|---|---|
| CodeQL | Scans Python source and notebook code for security weaknesses. |
| Gitleaks | Detects accidentally committed credentials, tokens, and other secrets across Git history. |
| Dependency Review | Blocks pull requests that introduce dependencies with moderate-or-higher known vulnerabilities. |
| pip-audit | Audits declared Python dependencies when a requirements file or `pyproject.toml` exists. |
| Immutable action references | Every third-party GitHub Action is pinned to a full commit SHA. |
| Least-privilege permissions | Workflows default to `contents: read`; only CodeQL receives narrowly scoped `security-events: write` to upload findings. |
| Path containment | Rejects repository paths and symlinks that resolve outside the checkout root. |
| XLSX validation | Treats `.xlsx` files as ZIP archives and checks member paths, encryption, macros, external links, archive size, and suspicious compression ratios. |
| Notebook policy | Requires valid nbformat 4 JSON, cleared outputs, null execution counts, bounded cell size, and no shell/system execution patterns. |
| CSV formula-injection detection | Rejects cells beginning with spreadsheet formula triggers (`=`, `+`, `@`, or nonnumeric `-`). |

## Workflow behavior

- Security checks run on pull requests and pushes to `main`.
- CodeQL and Gitleaks also run on a schedule.
- Validation is static: notebooks, spreadsheet formulas, macros, and embedded objects are never executed.
- Gitleaks PR comments and artifact uploads are disabled so the scan can operate with read-only repository permissions.

## Contributor requirements

Before opening a pull request:

```bash
python scripts/security/validate_repository.py
```

For notebooks, clear all outputs and execution counts before committing. For CSV files containing legitimate text beginning with a formula character, neutralize the value at export time (for example, prefix it with an apostrophe) and document the transformation.

## Important limitation

Automated checks reduce risk but cannot guarantee that a file is safe. Never place real employee personal data, passwords, API keys, access tokens, private certificates, or confidential company exports in this public repository.
