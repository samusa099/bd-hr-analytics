# Data Provenance

## Source Status

All data in **BD HR Analytics** is synthetically generated for education, portfolio development and analytics practice.

- No real company records are included.
- No real employee, buyer or production records are included.
- Names, IDs, salaries, departments, events, results, awards and interventions are fictional or simulated.
- The professional case company is **KAS Ltd.**, operating inside the fictional **XYZ Export Processing Zone, Bangladesh**.

## Current Analytical Baseline

The published CSV files were originally generated as a general synthetic HR analytics baseline. The KAS Ltd. professional case uses that baseline for workforce, recruitment, learning and KPI practice while proposing additional manufacturing-oriented challenge datasets.

Some existing synthetic identifiers may retain legacy prefixes. Those prefixes do not identify a real organisation and must not be interpreted as evidence from another employer.

Proposed case extensions—such as machine downtime, quality incidents, production-line performance and buyer-order changes—should not be described as published evidence unless the corresponding files are present in the repository.

## Generation Approach

The baseline dataset was designed to support coherent analysis across:

- workforce composition;
- turnover and early attrition;
- absenteeism and overtime;
- recruitment funnel performance;
- learning and manager capability;
- performance and engagement;
- compliance and strategic initiatives.

The KAS Ltd. case extends the analytical design toward:

- export-manufacturing workforce planning;
- specialist skill dependency;
- machine and workload incident analysis;
- cross-functional action governance;
- automatic refresh controls;
- responsible AI and role-based reporting.

Values were generated to be plausible for analytical practice, not to reproduce a real employer.

## Data Layers

```text
Synthetic source-style data
        ↓
Raw CSV layer
        ↓
Validated clean tables
        ↓
Analysis-ready KPI tables
        ↓
BI-ready views and dashboards
```

Raw CSV values must remain unchanged. Cleaning is performed in separate SQL tables or analysis outputs.

## Date and Geography

- Geography: Bangladesh-focused fictional export-manufacturing context
- Reporting period: project-defined synthetic period
- Organisation: fictional KAS Ltd. case
- Operating location: fictional XYZ Export Processing Zone

## Validation

The repository includes:

- stable CSV headers;
- a data dictionary;
- SQLite schema and cleaning scripts;
- duplicate-key and range checks;
- a data-quality issue log;
- SQLite integrity checks;
- repository security validation;
- dashboard QA and ethics checklists.

## Limitations

- Simulated data cannot validate a real HR or operating policy.
- Before-and-after movement does not prove causality.
- Risk scores are illustrative and may omit relevant context.
- Salary, production and workforce patterns must not be treated as market benchmarks.
- Proposed case datasets are not evidence until the corresponding files are published.
- Any production use requires lawful data collection, governance, fairness review, security controls and human accountability.

## Licensing

- Code and scripts: MIT
- Synthetic dataset: CC BY 4.0
- Documentation: CC BY 4.0

Attribution:

```text
Musa. BD HR Analytics: KAS Ltd. HR Business Partnership and Operating Transformation Case, Version 0.3.0.
```

## Responsible-Use Statement

This project must not be used to make automated hiring, termination, promotion, disciplinary, medical or other high-impact employment decisions.
