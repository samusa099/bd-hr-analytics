# Data Provenance

## Source status

All data in **BD HR Analytics** is synthetically generated for education, portfolio development and analytics practice.

- No real company records are included.
- No real employee records are included.
- Names, IDs, salaries, departments, results and interventions are fictional or simulated.
- The fictional company is **Nabodoy Commerce & Services Ltd.**

## Generation approach

The dataset was designed to support a coherent startup-to-SME HR transformation story across:

- workforce composition;
- turnover and early attrition;
- absenteeism and overtime;
- recruitment funnel performance;
- learning and manager capability;
- performance and engagement;
- compliance and strategic initiatives.

Values were generated to be plausible for analytical practice, not to reproduce a real employer.

## Data layers

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

## Date and geography

- Geography: Bangladesh-focused fictional SME context
- Reporting period: project-defined synthetic period
- Organisation: fictional private-sector startup-to-SME story

## Validation

The repository includes:

- stable CSV headers;
- a data dictionary;
- SQLite schema and cleaning scripts;
- duplicate-key and range checks;
- a data-quality issue log;
- SQLite integrity checks;
- dashboard QA and ethics checklists.

## Limitations

- Simulated data cannot validate a real HR policy.
- Before-and-after movement does not prove causality.
- Risk scores are illustrative and may omit relevant context.
- Salary and workforce patterns should not be treated as market benchmarks.
- Any production use requires lawful data collection, governance, fairness review and human accountability.

## Licensing

- Code and scripts: MIT
- Synthetic dataset: CC BY 4.0
- Documentation: CC BY 4.0

Attribution:

```text
Musa. BD HR Analytics: Bangladesh SME HR Strategy Transformation, Version 0.3.0.
```

## Responsible-use statement

This project must not be used to make automated hiring, termination, promotion, disciplinary, medical or other high-impact employment decisions.
