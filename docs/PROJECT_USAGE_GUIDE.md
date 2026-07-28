# 🛠️ Project Usage Guide

<p align="center">
  <strong>Use one completely synthetic HR analytics project across Excel, Power BI, Looker Studio, Python, SQL, SQLite, DBeaver, GitHub and Kaggle.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Level-Beginner%20Friendly-16A34A?style=for-the-badge" alt="Beginner friendly" />
  <img src="https://img.shields.io/badge/Data-CSV-14B8A6?style=for-the-badge" alt="CSV data" />
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel dashboard" />
  <img src="https://img.shields.io/badge/Power%20BI-Practice-F2C811?style=for-the-badge&logo=powerbi&logoColor=000000" alt="Power BI practice" />
  <img src="https://img.shields.io/badge/SQLite-DBeaver-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite and DBeaver" />
  <img src="https://img.shields.io/badge/Portfolio-Musa-7C3AED?style=for-the-badge" alt="Musa portfolio" />
</p>

## 🎯 What This Project Supports

Use the repository to practise:

- HR KPI definition and interpretation;
- raw-to-clean data workflows;
- workforce and turnover analysis;
- recruitment funnel and source-quality analysis;
- learning and manager-capability analysis;
- intervention tracking;
- SQL, SQLite and DBeaver;
- Power BI modelling and dashboard storytelling;
- responsible people analytics;
- portfolio and interview presentation.

> Every record and result is synthetic. This project is not a production employment-decision system.

## ⚡ Fastest Start

1. Download or clone the repository.
2. Review [`../data/csv/`](../data/csv/).
3. Open the Excel dashboard in [`../dashboards/excel/`](../dashboards/excel/).
4. Read [`CASE_STUDY.md`](CASE_STUDY.md).
5. Build the SQLite database:

```bash
python scripts/build_sqlite_database.py
```

6. Open `database/bd_hr_analytics.sqlite` in DBeaver.
7. Rebuild one Power BI page using [`../dashboards/power-bi/README.md`](../dashboards/power-bi/README.md).

## 🗂️ Folder Navigation

| Folder | Contents | Best use |
|---|---|---|
| [`../assets/cover/`](../assets/cover/) | Project cover | GitHub and portfolio presentation |
| [`../data/raw/`](../data/raw/) | Source-style synthetic data | Cleaning practice |
| [`../data/processed/`](../data/processed/) | Analysis-ready KPI tables | Reporting practice |
| [`../data/dictionary/`](../data/dictionary/) | Field definitions | Governance and interpretation |
| [`../data/csv/`](../data/csv/) | Central CSV copies | Excel, Power BI, SQL and Kaggle |
| [`../dashboards/excel/`](../dashboards/excel/) | Excel dashboard | Immediate review |
| [`../dashboards/power-bi/`](../dashboards/power-bi/) | DAX, theme, model and previews | Native Power BI build |
| [`../dashboards/looker-studio/`](../dashboards/looker-studio/) | Cloud-dashboard guidance | Looker Studio practice |
| [`../analysis/notebooks/`](../analysis/notebooks/) | Python notebooks | Diagnostics and impact analysis |
| [`../sql/`](../sql/) | SQLite schema, cleaning, views and queries | DBeaver and SQL practice |
| [`../scripts/`](../scripts/) | Reproducible execution scripts | Automated local build |
| [`../database/`](../database/) | Generated SQLite output guidance | Local database use |
| [`../metadata/`](../metadata/) | Dataset and publishing metadata | Governance and Kaggle |
| [`../docs/`](../docs/) | Case, ethics, rules and portfolio guides | Learning and presentation |

## 📊 Tool-by-Tool Usage

### Excel

Open:

```text
dashboards/excel/HR_Strategy_Transformation_Dashboard.xlsx
```

Use it to review executive KPIs, department risk, intervention progress and the overall synthetic business story.

### Power BI

Follow [`../dashboards/power-bi/README.md`](../dashboards/power-bi/README.md).

Core workflow:

1. import central CSV files or SQLite BI-ready views;
2. create date and department dimensions;
3. build one-to-many relationships;
4. add DAX measures;
5. import the supplied theme;
6. recreate the six report pages;
7. validate calculations and interactions;
8. add visible synthetic-data notices;
9. save the native `.pbix`.

### SQL, SQLite and DBeaver

Follow [`../sql/README.md`](../sql/README.md).

Script sequence:

```text
sql/sqlite/01_create_schema.sql
sql/sqlite/02_data_cleaning.sql
sql/sqlite/03_analytics_views.sql
sql/sqlite/04_portfolio_queries.sql
```

Automated build:

```bash
python scripts/build_sqlite_database.py
```

The cleaning workflow preserves `raw_*` tables, creates `clean_*` tables, logs invalid values and exposes aggregated BI-ready views.

### Python

Run:

```text
analysis/notebooks/01_hr_diagnostic.ipynb
analysis/notebooks/02_intervention_impact.ipynb
```

Install dependencies:

```bash
pip install -r requirements.txt
```

### Looker Studio

Use files in [`../dashboards/looker-studio/`](../dashboards/looker-studio/). Add a visible synthetic-data notice before publishing.

## 🧩 Task Checklist

| Task ID | Priority | Deliverable | Status |
|---|---:|---|---|
| USE-01 | High | Review structure and documentation | Ready |
| USE-02 | High | Validate central CSV files | Ready |
| USE-03 | High | Test Excel dashboard | Ready |
| USE-04 | High | Build SQLite database | Ready |
| USE-05 | High | Run cleaning and BI-ready views | Ready |
| USE-06 | High | Build Power BI report | Pending practice |
| USE-07 | Medium | Build Looker Studio version | Optional |
| USE-08 | Medium | Execute Python notebooks | Ready |
| USE-09 | High | Export final portfolio screenshots | Pending dashboard build |
| USE-10 | High | Complete ethics and release checks | Pending release |

## 🧑‍💻 Usability Paths

### 30-minute review

Read the case study, inspect three KPI CSVs, open the Excel dashboard, view the Power BI concepts and read the limitations.

### SQL practice

Create the SQLite database, inspect raw tables, run cleaning, review data-quality issues and query BI-ready views.

### Power BI portfolio

Build the star schema, create six report pages, export high-resolution screenshots and explain the business problem, intervention and simulated result.

### Interview presentation

Present:

1. business problem;
2. connected HR diagnosis;
3. intervention design;
4. analytics workflow;
5. simulated outcome;
6. remaining risk;
7. ethical limitation.

## 🧪 Practice Levels

### Beginner

- filter and sort CSVs;
- calculate net headcount change;
- rank departments by risk;
- create basic charts;
- run supplied SQL queries.

### Intermediate

- add SQL cleaning rules;
- create a date dimension;
- build a recruitment funnel;
- create Power BI drill-through;
- compare CSV and SQLite results.

### Advanced

- review query plans and indexes;
- add automated validation;
- design a star schema;
- create new DAX measures;
- test stronger causal designs without overstating results;
- document a controlled and ethical AI use case.

## ✅ Validation

- [ ] CSV headers are stable and readable.
- [ ] Raw data remains unchanged.
- [ ] SQLite integrity check returns `ok`.
- [ ] Data-quality issues are reviewed.
- [ ] Dates and percentages use correct types.
- [ ] Excel opens without repair warnings.
- [ ] Notebook paths are portable.
- [ ] SQL views use documented grains.
- [ ] Dashboard results match source totals.
- [ ] Synthetic status is visible.
- [ ] No automated employment decision is enabled.
- [ ] Simulated trends are not presented as proven causation.

## ⚖️ Responsible Use

Do not use this project for automated hiring, promotion, termination, discipline, medical assessment or other high-impact employee decisions. Production adaptation requires lawful data collection, privacy protection, validation, fairness review and accountable human oversight.
