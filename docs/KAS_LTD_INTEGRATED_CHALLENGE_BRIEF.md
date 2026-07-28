# KAS Ltd. — Integrated Analytics Challenge Brief

<p align="center">
  <strong>A controlled 10–16 hour practice assignment combining HRBP judgement, data assurance, SQL, Excel, Power BI, Looker Studio and refresh governance.</strong>
</p>

> **Synthetic case:** KAS Ltd., XYZ Export Processing Zone and every person, buyer, event and performance result in this challenge are fictional.

---

## Challenge Objective

Develop a reproducible people-and-operations decision system for the synthetic KAS Ltd. case. The solution must explain the Q3 operational failure, support Q4 automation and remain usable when future monthly data is added.

This is not a collection of isolated charts. Each workstream must use a consistent department master, reporting period and KPI definition.

---

## Challenge 1 — Data Assurance

### Problem

The source package contains inconsistent department names, mixed date formats, repeated business keys, percentage values outside expected ranges, incomplete machine categories and attendance records that do not reconcile across roster, biometric and payroll sources.

### Required Decisions

- Which rows should be corrected?
- Which rows should be quarantined?
- Which values may remain null?
- Which issue materially changes a management conclusion?
- Which transformation requires explicit approval?

### Outputs

- immutable raw layer;
- clean layer;
- BI-ready layer;
- issue register;
- transformation log;
- validation summary.

---

## Challenge 2 — SQLite and DBeaver Control Model

Create:

```text
raw_* tables
clean_* tables
dim_* tables
fact_* tables or governed analytical views
```

Minimum views:

```text
vw_bi_executive_quarterly
vw_bi_department_people_risk
vw_bi_specialist_skill_pipeline
vw_bi_q3_incident_timeline
vw_bi_overtime_quality_relationship
vw_bi_action_governance
vw_data_quality_summary
```

The participant must explain the grain, primary key and intended consumer of each view.

---

## Challenge 3 — Excel Operational Review

Design a workbook for monthly control rather than executive presentation.

Minimum sections:

- data intake and validation;
- department exception register;
- attendance and overtime reconciliation;
- specialist vacancy and skill tracker;
- audit and action closure;
- Q3 recovery control;
- sign-off and refresh date.

The workbook must show which exceptions are routine, which require HRBP escalation and which require cross-functional executive action.

---

## Challenge 4 — Power BI Decision Model

Build at least three of the seven proposed pages. One page must be **Q3 Incident Reconstruction**.

### Minimum Modelling Requirements

- date and department dimensions;
- documented relationships;
- explicit measures;
- latest validated refresh date;
- drill-through or tooltip detail;
- synthetic-data notice;
- human-review statement;
- no unsupported causal claim.

### Executive Questions

- Which risk could affect shipment or buyer confidence within 30 days?
- Is overtime being used as a temporary recovery mechanism or a recurring operating model?
- Which department result depends on another department’s delayed action?
- Which apparent improvement may be explained by order mix or reporting timing?

---

## Challenge 5 — Looker Studio Management View

Create a browser-oriented aggregated view.

Required controls:

- quarter;
- department group;
- action status;
- latest validation date.

Do not expose employee-level risk, grievance detail or unnecessary personal attributes.

---

## Challenge 6 — Future-Data Refresh Design

New data should not enter the dashboard solely because the file technically loaded.

Define:

- expected file schema;
- file naming and reporting period;
- duplicate-period rule;
- validation threshold;
- quarantine process;
- issue owner;
- management sign-off;
- refresh audit log;
- rollback process.

Provide a diagram and a one-page operating procedure.

---

## Challenge 7 — HRBP Decision Memo

Address the CEO and include:

1. the most material Q1 risk;
2. the strongest but still qualified Q2 improvement;
3. the Q3 coupled failure;
4. one Q4 automation use case to approve;
5. one use case to delay;
6. three leadership decisions;
7. the evidence limitation that management must not ignore.

---

## Submission Levels

### Core Submission — Approximately 10 Hours

- clean data;
- three SQL views;
- Excel control;
- three Power BI pages;
- decision memo.

### Complete Submission — Approximately 12–16 Hours

- full SQL model;
- five or more Power BI pages;
- Looker Studio view;
- automated intake design;
- incident analysis;
- documented quality assurance.

### Advanced Extension

- parameterised ingestion script;
- anomaly review queue;
- scenario model;
- role-based access design;
- automated validation report.

---

## Scoring Principle

The project rewards defensible judgement rather than volume. A smaller solution with controlled data, clear assumptions and decision-relevant visuals should score above a larger solution built on undocumented transformations.

Participant governance and submission instructions: [`PARTICIPANT_SUBMISSION_GOVERNANCE.md`](PARTICIPANT_SUBMISSION_GOVERNANCE.md)
