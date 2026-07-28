# 🛠️ Project Usage Guide

<p align="center">
  <strong>Use one structured HR analytics project across Excel, Power BI, Looker Studio, Python, SQL, GitHub and Kaggle.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Level-Beginner%20Friendly-16A34A?style=for-the-badge" alt="Beginner Friendly" />
  <img src="https://img.shields.io/badge/Data-CSV-14B8A6?style=for-the-badge" alt="CSV Data" />
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Excel Dashboard" />
  <img src="https://img.shields.io/badge/Power%20BI-Practice-F2C811?style=for-the-badge&logo=powerbi&logoColor=000000" alt="Power BI Practice" />
  <img src="https://img.shields.io/badge/Python%20%2B%20SQL-Analytics-2563EB?style=for-the-badge" alt="Python and SQL" />
  <img src="https://img.shields.io/badge/Portfolio-Ready-7C3AED?style=for-the-badge" alt="Portfolio Ready" />
</p>

---

## 🎯 What This Project Helps You Practise

The repository demonstrates how an HR Executive can analyse a common Bangladesh SME growth problem and communicate a structured response through data.

You can use it to practise:

- HR KPI definition;
- data cleaning and validation;
- workforce and turnover analysis;
- recruitment funnel analysis;
- learning and manager capability analysis;
- intervention tracking;
- dashboard design and storytelling;
- responsible people analytics;
- portfolio and interview presentation.

> All records are synthetic and created for learning, demonstration and portfolio use.

---

## ⚡ Start Here

### Fastest beginner workflow

1. Download or clone the repository.
2. Open [`../data/csv/`](../data/csv/).
3. Review `monthly_hr_kpis.csv`, `department_scorecard.csv` and `intervention_impact.csv`.
4. Open the Excel dashboard in [`../dashboards/excel/`](../dashboards/excel/).
5. Read the case study in [`CASE_STUDY.md`](CASE_STUDY.md).
6. Rebuild one dashboard page using the Power BI guide.
7. Document what you learned and what you would improve.

### Recommended reading order

1. [`CASE_STUDY.md`](CASE_STUDY.md)
2. [`PROJECT_USAGE_GUIDE.md`](PROJECT_USAGE_GUIDE.md)
3. [`PROMOTION_PORTFOLIO.md`](PROMOTION_PORTFOLIO.md)
4. [`ETHICS_AND_LIMITATIONS.md`](ETHICS_AND_LIMITATIONS.md)
5. [`../dashboards/power-bi/README.md`](../dashboards/power-bi/README.md)

---

## 🗂️ Folder Navigation

| Folder | What it contains | Best use |
|---|---|---|
| [`../data/csv/`](../data/csv/) | Central CSV copies | Excel, Power BI, Python, SQL and Kaggle |
| [`../data/raw/`](../data/raw/) | Source-style synthetic records | Data cleaning and modelling practice |
| [`../data/processed/`](../data/processed/) | Analysis-ready KPI tables | Dashboard and reporting practice |
| [`../data/dictionary/`](../data/dictionary/) | Field definitions | Metric interpretation and governance |
| [`../dashboards/excel/`](../dashboards/excel/) | Excel dashboard workbook | Immediate review and presentation |
| [`../dashboards/power-bi/`](../dashboards/power-bi/) | DAX, model, theme and visual references | Native Power BI build practice |
| [`../dashboards/looker-studio/`](../dashboards/looker-studio/) | Page and calculated-field guidance | Shareable cloud dashboard practice |
| [`../analysis/notebooks/`](../analysis/notebooks/) | Python notebooks | Diagnostic and impact analysis |
| [`../analysis/sql/`](../analysis/sql/) | SQL query library | Query and KPI practice |
| [`../metadata/`](../metadata/) | Project and Kaggle metadata | Publishing and governance |
| [`../assets/`](../assets/) | Cover and architecture visuals | README and portfolio presentation |

---

## 📊 Tool-by-Tool Usage

### Excel

Open:

```text
dashboards/excel/HR_Strategy_Transformation_Dashboard.xlsx
```

Use it to:

- understand the project story quickly;
- review monthly KPI trends;
- compare department people risk;
- examine intervention progress;
- practise executive dashboard presentation.

### Power BI

Follow [`../dashboards/power-bi/README.md`](../dashboards/power-bi/README.md).

Core steps:

1. import CSV files;
2. create date and department dimensions;
3. build one-to-many relationships;
4. add DAX measures;
5. import the theme;
6. recreate six report pages;
7. validate filters and calculations;
8. save the final `.pbix` file.

### Looker Studio

Use the files in [`../dashboards/looker-studio/`](../dashboards/looker-studio/).

Recommended process:

1. upload processed CSV files to Google Sheets or BigQuery;
2. create the calculated fields;
3. build the leadership snapshot first;
4. add department and phase filters;
5. publish only after adding a synthetic-data notice.

### Python

Run the notebooks in order:

```text
analysis/notebooks/01_hr_diagnostic.ipynb
analysis/notebooks/02_intervention_impact.ipynb
```

Use a virtual environment and install:

```bash
pip install -r requirements.txt
```

### SQL

Open:

```text
analysis/sql/hr_strategy_queries.sql
```

Adapt date functions to your SQL engine. The queries can be practised in SQLite, DuckDB, PostgreSQL or MySQL with minor syntax adjustments.

---

## 👥 Task Assignment

| Task ID | Assigned to | Priority | Deliverable | Status |
|---|---|---:|---|---|
| USE-01 | Musa | High | Review folder structure and broken links | Ready |
| USE-02 | Musa | High | Validate all central CSV files | Ready |
| USE-03 | Musa | High | Test Excel dashboard opening and formulas | Ready |
| USE-04 | Musa | High | Build the Power BI report | Pending practice |
| USE-05 | Musa | Medium | Build a Looker Studio version | Optional |
| USE-06 | Musa | Medium | Execute both notebooks | Ready |
| USE-07 | Musa | Medium | Test SQL queries | Ready |
| USE-08 | Musa | High | Add final portfolio screenshots | Pending dashboard build |
| USE-09 | Musa | High | Complete ethics and release checks | Pending release |

### Definition of done

A usage task is complete when the output opens correctly, the instructions can be followed by another user, links work, and the result includes a synthetic-data notice.

---

## 🧑‍💻 Usability Paths

### Path A — 30-minute project review

- read the case study;
- inspect three processed CSV files;
- open the Excel dashboard;
- view the Power BI dashboard concepts;
- read the simulated results and limitations.

### Path B — Power BI portfolio build

- import all CSV files;
- build the star schema;
- create the six report pages;
- export high-resolution screenshots;
- add the `.pbix` file and screenshots to the repository;
- explain the business problem, intervention and outcome.

### Path C — Python and SQL practice

- run data-quality checks;
- reproduce department risk ranking;
- compare before and after periods;
- write new KPI queries;
- explain why the results are descriptive rather than causal.

### Path D — Interview presentation

Present the project in this sequence:

1. **Business problem:** startup growth exceeded HR process maturity.
2. **Diagnosis:** turnover, absence, recruitment, manager and compliance risks were connected.
3. **Intervention:** ten strategic HR contribution areas were prioritised.
4. **Evidence:** dashboards track simulated KPI improvement and remaining risk.
5. **Professional judgement:** employee-level risk requires context and human review.

---

## 🧪 Practice Exercises

### Beginner

- calculate net headcount change;
- rank departments by people-risk index;
- create a turnover trend chart;
- filter recruitment data by source;
- compare pre- and post-training scores.

### Intermediate

- create a date dimension;
- build a recruitment funnel;
- create a department drill-through page;
- add a KPI tooltip page;
- calculate rolling three-month averages.

### Advanced

- test alternative risk-score logic;
- build a workforce-cost scenario;
- add confidence intervals or statistical tests;
- design a controlled AI use-case register;
- evaluate whether an intervention could be measured through a stronger causal design.

---

## ✅ Validation Checklist

### Files

- [ ] CSV files open with correct headers.
- [ ] Excel workbook opens without repair warnings.
- [ ] Notebook paths resolve correctly.
- [ ] SQL file uses documented table names.
- [ ] Dashboard images open at full resolution.

### Data

- [ ] Employee IDs are unique where required.
- [ ] Dates are parsed correctly.
- [ ] Percentage fields are stored as decimals.
- [ ] Missing values are reviewed.
- [ ] No real personal data is present.

### Reporting

- [ ] KPI titles answer a business question.
- [ ] Filters work consistently.
- [ ] Synthetic-data notices are visible.
- [ ] Results are not presented as proven causation.
- [ ] Employee-level outputs require human review.

---

## 🧯 Common Problems

| Problem | Likely cause | Fix |
|---|---|---|
| Percentage shows 1,780% | Decimal field was multiplied twice | Format the original decimal as percentage |
| Date hierarchy is missing | Date field imported as text | Change data type and create a date table |
| Visual totals look wrong | Relationship or filter direction issue | Review the star schema |
| CSV characters look unusual | Encoding mismatch | Import as UTF-8 |
| Notebook cannot find files | Working directory differs | Run from the notebook folder or update `ROOT` |
| Power BI page looks crowded | Too many visuals or slicers | Prioritise the management decision |

---

## 📦 Publishing and Release Use

Use the same structured project for GitHub and Kaggle. Do not create separate project structures.

Before publishing:

- complete the validation checklist;
- review [`ETHICS_AND_LIMITATIONS.md`](ETHICS_AND_LIMITATIONS.md);
- update `VERSION` and `CHANGELOG.md`;
- create a release ZIP from the clean project files;
- attach the ZIP to the GitHub Release rather than storing multiple historical ZIPs in `releases/`;
- mark the Kaggle dataset as synthetic.

---

<p align="center"><strong>Start with the business question, validate the data, then build the visual.</strong></p>
