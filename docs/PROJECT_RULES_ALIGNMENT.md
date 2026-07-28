# 🧭 Project Rules Alignment

<p align="center">
  <strong>How the Unified Analytics Project Rules are applied to this completely synthetic HR analytics portfolio.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Rules-Applied-16A34A?style=for-the-badge" alt="Rules applied" />
  <img src="https://img.shields.io/badge/Ethics-Human%20Review-2563EB?style=for-the-badge" alt="Human review" />
  <img src="https://img.shields.io/badge/Data-Synthetic-F97316?style=for-the-badge" alt="Synthetic data" />
  <img src="https://img.shields.io/badge/Scope-Fit%20for%20Purpose-7C3AED?style=for-the-badge" alt="Fit for purpose" />
</p>

## Policy statement

This repository follows a layered analytics architecture, preserves authoritative source data, separates code, reports and documentation, and publishes only documented, validated, ethical and portfolio-ready assets.

The rules are applied exactly where they support this project. Rules that would conflict with the project's synthetic story, responsible-use boundaries or single-archive distribution goal are adapted or excluded and documented below.

## Applied rules

| Ruleset area | Application in this repository |
|---|---|
| Authoritative source layer | `data/raw/` is preserved; SQL cleaning creates separate `clean_*` tables |
| Separation of assets | Data, dashboards, notebooks, SQL, scripts, database guidance, metadata and docs use dedicated folders |
| Clean entry point | README follows cover → title → badges → overview → use cases → workflow → quick start → ethics → citation |
| File naming | New files use descriptive, stable names; formal versions are limited to releases |
| Metadata and dictionary | Dataset metadata and a CSV data dictionary are included |
| Practice levels | Beginner, intermediate and advanced workflows are documented |
| Portfolio assets | Cover, dashboard previews, CSVs, Excel, notebooks, SQL and guides are included |
| Security and privacy | No secrets, real employee identifiers, private payroll, medical records or production credentials are permitted |
| Python and notebooks | Paths must remain repository-relative and outputs must be reproducible |
| Power BI and Excel | CSV sources, documented model, DAX, theme, previews and separate report assets are provided |
| SQL and database | SQLite schema, cleaning scripts, BI-ready views and DBeaver guidance are provided |
| Validation | Cleaning logs invalid values without overwriting raw data; the build script runs SQLite integrity checks |
| Release hygiene | Historical duplicate archives are removed; one current unified ZIP is retained |
| Author identity | The public author name is consistently presented as **Musa** |

## Adapted rules

### GitHub and Kaggle packaging

The unified rules normally distinguish GitHub engineering files from a smaller Kaggle package. This project keeps that principle but uses **one clean unified distribution ZIP**, because the project goal is simple cross-platform management.

The archive should exclude development clutter such as `.github/`, caches, branches, temporary files and obsolete archives even though those items may exist in the GitHub engineering workspace.

### Repository root

The root remains concise, with one deliberate exception:

```text
bd-hr-analytics-unified-project.zip
```

This is retained as the single current distribution asset. Duplicate historical ZIPs are not retained.

### Data layers

The existing project uses `raw`, `processed`, `dictionary` and central `csv` folders. The SQL workflow adds a logical raw → clean → BI-ready architecture without silently relocating or overwriting published data.

## Rules intentionally not applied

| Excluded rule or asset | Reason |
|---|---|
| Real employee or company data | Conflicts with the fully synthetic portfolio goal |
| Automated hiring, promotion, discipline or termination logic | Conflicts with ethical human-review requirements |
| Fabricated `.pbix` output | A native Power BI file must be genuinely built and validated |
| Predictive claims presented as fact | The project is descriptive and does not establish causality |
| Unused folders | The ruleset states that projects should not create empty folders without purpose |
| Multiple Kaggle/GitHub archives | Conflicts with the agreed single-archive management approach |
| Unnecessary enterprise CI or branch bureaucracy | Not required for the current educational portfolio scope; may be added later when useful |

## Ethical operating boundary

The following rules override convenience or visual storytelling:

1. synthetic status must remain visible;
2. raw source values must not be silently replaced;
3. invalid values must be logged for review;
4. employee-risk outputs must be aggregated where possible;
5. individual risk scores must never make automated employment decisions;
6. simulated improvements must not be described as verified real-world impact;
7. any production adaptation requires lawful collection, privacy controls, bias testing and accountable human oversight.

## Readiness checklist

- [x] Professional project cover
- [x] Synthetic-data declaration
- [x] Central CSV access
- [x] Data dictionary and metadata
- [x] Excel dashboard
- [x] Power BI model, DAX, theme and previews
- [x] Python notebooks
- [x] DBeaver/SQLite cleaning and analytics scripts
- [x] Ethics and limitations guide
- [x] Provenance and citation metadata
- [x] Single unified distribution archive
- [ ] Native `.pbix` built and validated
- [ ] Formal GitHub Release published with the current ZIP

## Maintainer

**Musa**

Ruleset application status: **fit-for-purpose, synthetic-data-safe and portfolio-ready**.
