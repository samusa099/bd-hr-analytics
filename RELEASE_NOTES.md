# Release Notes — v0.4.0

<p align="center">
  <img src="https://img.shields.io/badge/Release-v0.4.0-2563EB?style=for-the-badge" alt="Release v0.4.0" />
  <img src="https://img.shields.io/badge/Status-Ready%20for%20Publication-16A34A?style=for-the-badge" alt="Ready for publication" />
  <img src="https://img.shields.io/badge/Data-100%25%20Synthetic-F97316?style=for-the-badge" alt="Synthetic data" />
</p>

## Release Title

```text
KAS Ltd. HR Business Partnership and Analytics Practice Package v0.4.0
```

## Summary

Version `v0.4.0` publishes the professional KAS Ltd. transformation case and separates repository governance from the participant practice package.

The public repository remains the authoritative documentation, source, security and contribution workspace. The downloadable practice archive is published separately as a GitHub Release asset and is not committed to `main`.

## Major Additions

- professional Q1–Q4 KAS Ltd. HRBP transformation case;
- Musa’s progression from Senior Executive to Assistant Manager — HR Business Partnering & People Analytics;
- integrated data assurance, SQLite, Excel, Power BI, Looker Studio and HRBP challenge;
- controlled `participant-submissions/` workspace;
- dedicated `participant-review` branch;
- required checks that reject participant solution pull requests targeting `main`;
- SQLite practice database included in the release package;
- release-based download workflow.

## Practice Release Asset

Attach this file to the new GitHub Release:

```text
bd-hr-analytics-practice-files-v0.4.0.zip
```

The archive contains only practice-oriented assets:

- CSV datasets;
- JSON metadata and Power BI theme files;
- SQLite database;
- Excel workbook;
- Jupyter notebooks;
- SQL and DAX files.

The archive excludes:

- `.git` and `.github`;
- repository rulesets;
- governance documentation;
- `CHANGELOG.md`;
- `RELEASE_NOTES.md`;
- security workflows;
- contribution governance;
- duplicate archives.

## Private Governance Package

The following package is maintained privately and must not be attached to the public release:

```text
bd-hr-analytics-private-rulesets-v0.4.0.zip
```

It contains validated GitHub ruleset JSON templates for manual administrative import.

## Recommended GitHub Release Settings

- **Tag:** `v0.4.0`
- **Target:** `main`
- **Release title:** `KAS Ltd. HR Business Partnership and Analytics Practice Package v0.4.0`
- **Set as latest release:** Yes
- **Pre-release:** No
- **Public asset:** `bd-hr-analytics-practice-files-v0.4.0.zip`
- **Private ruleset package:** Do not upload publicly

## Installation and Practice

1. Open the repository Releases page.
2. Download `bd-hr-analytics-practice-files-v0.4.0.zip`.
3. Extract the archive locally.
4. Use CSV files with Excel, Power BI, Python, SQL or DBeaver.
5. Open `database/bd_hr_analytics_practice.sqlite` in DBeaver or another SQLite client.
6. Use the notebooks, SQL and DAX assets for the selected challenge workstream.
7. Read the full case and submission instructions from the repository documentation.

## Governance and Security

- Release ZIP files are not stored in `main`.
- Public ruleset JSON templates have been removed from the repository tree.
- Participant submissions target `participant-review`, not `main`.
- Required `validate-project` and `security-checks` checks remain active.
- Published release tags should be treated as immutable.

## Ethics Notice

All records, companies, employees, buyers, incidents and performance outcomes are synthetic. The materials must not be used to automate real hiring, termination, promotion, disciplinary, medical or other high-impact employment decisions.

## Known Limitations

- The native Power BI `.pbix` file remains a participant practice deliverable.
- Simulated KPI movement does not prove causality.
- The release archive is a practice distribution package, not a production HR information system.

## Publication Checklist

- Professional case published: Complete
- Participant workspace published: Complete
- Practice-only ZIP prepared: Complete
- SQLite integrity check: Passed
- Public repository ZIP removed: Complete
- Public ruleset JSON removed: Complete
- README release redirect: Complete
- Version updated to `v0.4.0`: Complete
- GitHub Release creation and asset upload: Maintainer publication step
