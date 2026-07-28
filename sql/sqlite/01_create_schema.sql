-- BD HR Analytics — SQLite raw schema
-- Purpose: create load-friendly raw tables for DBeaver or SQLite.
-- Data status: 100% synthetic portfolio data.
-- Raw tables preserve imported values; cleaning happens in 02_data_cleaning.sql.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS project_metadata (
    metadata_key TEXT PRIMARY KEY,
    metadata_value TEXT NOT NULL
);

INSERT OR REPLACE INTO project_metadata (metadata_key, metadata_value) VALUES
('project_name', 'BD HR Analytics'),
('company_story', 'Nabodoy Commerce & Services Ltd. (fictional)'),
('data_status', 'Synthetic portfolio data'),
('decision_rule', 'Human review required; no automated employment decisions');

CREATE TABLE IF NOT EXISTS raw_employees (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id TEXT,
    department TEXT,
    designation_level TEXT,
    location TEXT,
    hire_date TEXT,
    employment_status TEXT,
    monthly_salary_bdt TEXT,
    engagement_score TEXT,
    performance_score TEXT,
    absence_rate TEXT,
    monthly_overtime_hours TEXT,
    training_hours_last_12m TEXT,
    critical_role TEXT,
    people_risk_score TEXT,
    risk_band TEXT
);

CREATE TABLE IF NOT EXISTS raw_recruitment (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    requisition_id TEXT,
    department TEXT,
    source TEXT,
    applicants TEXT,
    interviews TEXT,
    offers TEXT,
    joins TEXT,
    time_to_fill_days TEXT,
    cost_per_hire_bdt TEXT,
    quality_of_hire_score TEXT,
    retention_90d_rate TEXT,
    phase TEXT
);

CREATE TABLE IF NOT EXISTS raw_learning (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    learning_record_id TEXT,
    employee_id TEXT,
    department TEXT,
    program TEXT,
    hours TEXT,
    completion_status TEXT,
    pre_assessment_score TEXT,
    post_assessment_score TEXT,
    behavior_application_score TEXT
);

CREATE TABLE IF NOT EXISTS raw_monthly_hr_kpis (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    month TEXT,
    headcount TEXT,
    hires TEXT,
    exits TEXT,
    annualized_turnover_rate TEXT,
    absenteeism_rate TEXT,
    overtime_cost_ratio TEXT,
    avg_engagement_score TEXT,
    avg_performance_score TEXT,
    avg_time_to_fill_days TEXT,
    training_completion_rate TEXT,
    compliance_documentation_rate TEXT,
    manager_effectiveness_score TEXT,
    early_attrition_90d_rate TEXT,
    phase TEXT
);

CREATE TABLE IF NOT EXISTS raw_department_monthly_kpis (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    month TEXT,
    department TEXT,
    headcount TEXT,
    annualized_turnover_rate TEXT,
    absenteeism_rate TEXT,
    avg_engagement_score TEXT,
    avg_performance_score TEXT,
    overtime_hours TEXT,
    avg_vacancy_days TEXT,
    people_risk_index TEXT
);

CREATE TABLE IF NOT EXISTS raw_department_scorecard (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    department TEXT,
    headcount TEXT,
    turnover_rate TEXT,
    absenteeism_rate TEXT,
    engagement_score TEXT,
    performance_score TEXT,
    overtime_hours TEXT,
    vacancy_days TEXT,
    people_risk_index TEXT,
    risk_band TEXT,
    priority_action TEXT
);

CREATE TABLE IF NOT EXISTS raw_intervention_impact (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    strategy_area TEXT,
    business_problem TEXT,
    intervention TEXT,
    baseline TEXT,
    target TEXT,
    actual TEXT,
    owner TEXT,
    status TEXT
);

CREATE TABLE IF NOT EXISTS raw_data_dictionary (
    _source_row_id INTEGER PRIMARY KEY AUTOINCREMENT,
    file TEXT,
    field TEXT,
    data_type TEXT,
    description TEXT
);
