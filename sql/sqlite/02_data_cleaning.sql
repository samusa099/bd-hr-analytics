-- BD HR Analytics — SQLite data cleaning
-- Run after importing CSVs into raw_* tables.
-- Raw tables are never overwritten.
-- Invalid values become NULL and are logged in data_quality_issues.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS data_quality_issues;
CREATE TABLE data_quality_issues (
    issue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    source_table TEXT NOT NULL,
    record_key TEXT,
    field_name TEXT NOT NULL,
    issue_type TEXT NOT NULL,
    observed_value TEXT,
    review_note TEXT NOT NULL
);

-- Employees -------------------------------------------------------------------
DROP TABLE IF EXISTS clean_employees;
CREATE TABLE clean_employees (
    employee_id TEXT PRIMARY KEY,
    department TEXT NOT NULL,
    designation_level TEXT,
    location TEXT,
    hire_date TEXT,
    employment_status TEXT,
    monthly_salary_bdt REAL,
    engagement_score REAL,
    performance_score REAL,
    absence_rate REAL,
    monthly_overtime_hours REAL,
    training_hours_last_12m REAL,
    critical_role TEXT,
    people_risk_score REAL,
    risk_band TEXT
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY UPPER(TRIM(employee_id))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_employees
    WHERE NULLIF(TRIM(employee_id), '') IS NOT NULL
)
INSERT INTO clean_employees
SELECT
    UPPER(TRIM(employee_id)),
    COALESCE(NULLIF(TRIM(department), ''), 'Unknown'),
    NULLIF(TRIM(designation_level), ''),
    NULLIF(TRIM(location), ''),
    CASE WHEN date(TRIM(hire_date)) IS NOT NULL THEN date(TRIM(hire_date)) END,
    CASE
        WHEN LOWER(TRIM(employment_status)) IN ('active','inactive','exited')
        THEN UPPER(SUBSTR(LOWER(TRIM(employment_status)),1,1)) || SUBSTR(LOWER(TRIM(employment_status)),2)
        ELSE NULLIF(TRIM(employment_status), '')
    END,
    CASE WHEN CAST(monthly_salary_bdt AS REAL) >= 0 THEN CAST(monthly_salary_bdt AS REAL) END,
    CASE WHEN CAST(engagement_score AS REAL) BETWEEN 0 AND 100 THEN CAST(engagement_score AS REAL) END,
    CASE WHEN CAST(performance_score AS REAL) BETWEEN 0 AND 100 THEN CAST(performance_score AS REAL) END,
    CASE WHEN CAST(absence_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(absence_rate AS REAL) END,
    CASE WHEN CAST(monthly_overtime_hours AS REAL) >= 0 THEN CAST(monthly_overtime_hours AS REAL) END,
    CASE WHEN CAST(training_hours_last_12m AS REAL) >= 0 THEN CAST(training_hours_last_12m AS REAL) END,
    CASE
        WHEN LOWER(TRIM(critical_role)) IN ('yes','y','true','1') THEN 'Yes'
        WHEN LOWER(TRIM(critical_role)) IN ('no','n','false','0') THEN 'No'
        ELSE NULL
    END,
    CASE WHEN CAST(people_risk_score AS REAL) BETWEEN 0 AND 100 THEN CAST(people_risk_score AS REAL) END,
    CASE
        WHEN LOWER(TRIM(risk_band)) = 'low' THEN 'Low'
        WHEN LOWER(TRIM(risk_band)) = 'medium' THEN 'Medium'
        WHEN LOWER(TRIM(risk_band)) = 'high' THEN 'High'
        ELSE 'Unclassified'
    END
FROM ranked
WHERE rn = 1;

INSERT INTO data_quality_issues
(source_table, record_key, field_name, issue_type, observed_value, review_note)
SELECT 'raw_employees', employee_id, 'employee_id', 'duplicate_key', employee_id,
       'Latest source row retained in clean_employees.'
FROM raw_employees
WHERE NULLIF(TRIM(employee_id), '') IS NOT NULL
GROUP BY UPPER(TRIM(employee_id))
HAVING COUNT(*) > 1;

INSERT INTO data_quality_issues
(source_table, record_key, field_name, issue_type, observed_value, review_note)
SELECT 'raw_employees', employee_id, 'hire_date', 'invalid_date', hire_date,
       'Invalid dates are stored as NULL; review the raw row.'
FROM raw_employees
WHERE NULLIF(TRIM(hire_date), '') IS NOT NULL
  AND date(TRIM(hire_date)) IS NULL;

INSERT INTO data_quality_issues
(source_table, record_key, field_name, issue_type, observed_value, review_note)
SELECT 'raw_employees', employee_id, 'absence_rate', 'out_of_range', absence_rate,
       'Expected a decimal between 0 and 1.'
FROM raw_employees
WHERE NULLIF(TRIM(absence_rate), '') IS NOT NULL
  AND CAST(absence_rate AS REAL) NOT BETWEEN 0 AND 1;

-- Recruitment -----------------------------------------------------------------
DROP TABLE IF EXISTS clean_recruitment;
CREATE TABLE clean_recruitment (
    requisition_id TEXT PRIMARY KEY,
    department TEXT NOT NULL,
    source TEXT,
    applicants INTEGER,
    interviews INTEGER,
    offers INTEGER,
    joins INTEGER,
    time_to_fill_days REAL,
    cost_per_hire_bdt REAL,
    quality_of_hire_score REAL,
    retention_90d_rate REAL,
    phase TEXT
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY UPPER(TRIM(requisition_id))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_recruitment
    WHERE NULLIF(TRIM(requisition_id), '') IS NOT NULL
)
INSERT INTO clean_recruitment
SELECT
    UPPER(TRIM(requisition_id)),
    COALESCE(NULLIF(TRIM(department), ''), 'Unknown'),
    NULLIF(TRIM(source), ''),
    CASE WHEN CAST(applicants AS INTEGER) >= 0 THEN CAST(applicants AS INTEGER) END,
    CASE WHEN CAST(interviews AS INTEGER) >= 0 THEN CAST(interviews AS INTEGER) END,
    CASE WHEN CAST(offers AS INTEGER) >= 0 THEN CAST(offers AS INTEGER) END,
    CASE WHEN CAST(joins AS INTEGER) >= 0 THEN CAST(joins AS INTEGER) END,
    CASE WHEN CAST(time_to_fill_days AS REAL) >= 0 THEN CAST(time_to_fill_days AS REAL) END,
    CASE WHEN CAST(cost_per_hire_bdt AS REAL) >= 0 THEN CAST(cost_per_hire_bdt AS REAL) END,
    CASE WHEN CAST(quality_of_hire_score AS REAL) BETWEEN 0 AND 100 THEN CAST(quality_of_hire_score AS REAL) END,
    CASE WHEN CAST(retention_90d_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(retention_90d_rate AS REAL) END,
    NULLIF(TRIM(phase), '')
FROM ranked
WHERE rn = 1;

INSERT INTO data_quality_issues
(source_table, record_key, field_name, issue_type, observed_value, review_note)
SELECT 'raw_recruitment', requisition_id, 'funnel_counts', 'logical_order',
       printf('applicants=%s, interviews=%s, offers=%s, joins=%s', applicants, interviews, offers, joins),
       'Expected applicants >= interviews >= offers >= joins.'
FROM raw_recruitment
WHERE CAST(applicants AS INTEGER) < CAST(interviews AS INTEGER)
   OR CAST(interviews AS INTEGER) < CAST(offers AS INTEGER)
   OR CAST(offers AS INTEGER) < CAST(joins AS INTEGER);

-- Learning --------------------------------------------------------------------
DROP TABLE IF EXISTS clean_learning;
CREATE TABLE clean_learning (
    learning_record_id TEXT PRIMARY KEY,
    employee_id TEXT,
    department TEXT,
    program TEXT,
    hours REAL,
    completion_status TEXT,
    pre_assessment_score REAL,
    post_assessment_score REAL,
    behavior_application_score REAL,
    FOREIGN KEY (employee_id) REFERENCES clean_employees(employee_id)
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY UPPER(TRIM(learning_record_id))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_learning
    WHERE NULLIF(TRIM(learning_record_id), '') IS NOT NULL
)
INSERT INTO clean_learning
SELECT
    UPPER(TRIM(learning_record_id)),
    NULLIF(UPPER(TRIM(employee_id)), ''),
    NULLIF(TRIM(department), ''),
    NULLIF(TRIM(program), ''),
    CASE WHEN CAST(hours AS REAL) >= 0 THEN CAST(hours AS REAL) END,
    CASE
        WHEN LOWER(TRIM(completion_status)) IN ('yes','completed','complete','true','1') THEN 'Completed'
        WHEN LOWER(TRIM(completion_status)) IN ('no','not completed','incomplete','false','0') THEN 'Not completed'
        ELSE NULLIF(TRIM(completion_status), '')
    END,
    CASE WHEN CAST(pre_assessment_score AS REAL) BETWEEN 0 AND 100 THEN CAST(pre_assessment_score AS REAL) END,
    CASE WHEN CAST(post_assessment_score AS REAL) BETWEEN 0 AND 100 THEN CAST(post_assessment_score AS REAL) END,
    CASE WHEN CAST(behavior_application_score AS REAL) BETWEEN 0 AND 100 THEN CAST(behavior_application_score AS REAL) END
FROM ranked
WHERE rn = 1;

-- Monthly HR KPIs --------------------------------------------------------------
DROP TABLE IF EXISTS clean_monthly_hr_kpis;
CREATE TABLE clean_monthly_hr_kpis (
    month TEXT PRIMARY KEY,
    headcount INTEGER,
    hires INTEGER,
    exits INTEGER,
    annualized_turnover_rate REAL,
    absenteeism_rate REAL,
    overtime_cost_ratio REAL,
    avg_engagement_score REAL,
    avg_performance_score REAL,
    avg_time_to_fill_days REAL,
    training_completion_rate REAL,
    compliance_documentation_rate REAL,
    manager_effectiveness_score REAL,
    early_attrition_90d_rate REAL,
    phase TEXT
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY date(TRIM(month))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_monthly_hr_kpis
    WHERE date(TRIM(month)) IS NOT NULL
)
INSERT INTO clean_monthly_hr_kpis
SELECT
    date(TRIM(month)),
    CAST(headcount AS INTEGER),
    CAST(hires AS INTEGER),
    CAST(exits AS INTEGER),
    CASE WHEN CAST(annualized_turnover_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(annualized_turnover_rate AS REAL) END,
    CASE WHEN CAST(absenteeism_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(absenteeism_rate AS REAL) END,
    CASE WHEN CAST(overtime_cost_ratio AS REAL) BETWEEN 0 AND 1 THEN CAST(overtime_cost_ratio AS REAL) END,
    CASE WHEN CAST(avg_engagement_score AS REAL) BETWEEN 0 AND 100 THEN CAST(avg_engagement_score AS REAL) END,
    CASE WHEN CAST(avg_performance_score AS REAL) BETWEEN 0 AND 100 THEN CAST(avg_performance_score AS REAL) END,
    CASE WHEN CAST(avg_time_to_fill_days AS REAL) >= 0 THEN CAST(avg_time_to_fill_days AS REAL) END,
    CASE WHEN CAST(training_completion_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(training_completion_rate AS REAL) END,
    CASE WHEN CAST(compliance_documentation_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(compliance_documentation_rate AS REAL) END,
    CASE WHEN CAST(manager_effectiveness_score AS REAL) BETWEEN 0 AND 100 THEN CAST(manager_effectiveness_score AS REAL) END,
    CASE WHEN CAST(early_attrition_90d_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(early_attrition_90d_rate AS REAL) END,
    NULLIF(TRIM(phase), '')
FROM ranked
WHERE rn = 1;

-- Department monthly KPIs ------------------------------------------------------
DROP TABLE IF EXISTS clean_department_monthly_kpis;
CREATE TABLE clean_department_monthly_kpis (
    month TEXT NOT NULL,
    department TEXT NOT NULL,
    headcount INTEGER,
    annualized_turnover_rate REAL,
    absenteeism_rate REAL,
    avg_engagement_score REAL,
    avg_performance_score REAL,
    overtime_hours REAL,
    avg_vacancy_days REAL,
    people_risk_index REAL,
    PRIMARY KEY (month, department)
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY date(TRIM(month)), LOWER(TRIM(department))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_department_monthly_kpis
    WHERE date(TRIM(month)) IS NOT NULL
      AND NULLIF(TRIM(department), '') IS NOT NULL
)
INSERT INTO clean_department_monthly_kpis
SELECT
    date(TRIM(month)),
    TRIM(department),
    CAST(headcount AS INTEGER),
    CASE WHEN CAST(annualized_turnover_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(annualized_turnover_rate AS REAL) END,
    CASE WHEN CAST(absenteeism_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(absenteeism_rate AS REAL) END,
    CASE WHEN CAST(avg_engagement_score AS REAL) BETWEEN 0 AND 100 THEN CAST(avg_engagement_score AS REAL) END,
    CASE WHEN CAST(avg_performance_score AS REAL) BETWEEN 0 AND 100 THEN CAST(avg_performance_score AS REAL) END,
    CASE WHEN CAST(overtime_hours AS REAL) >= 0 THEN CAST(overtime_hours AS REAL) END,
    CASE WHEN CAST(avg_vacancy_days AS REAL) >= 0 THEN CAST(avg_vacancy_days AS REAL) END,
    CASE WHEN CAST(people_risk_index AS REAL) BETWEEN 0 AND 100 THEN CAST(people_risk_index AS REAL) END
FROM ranked
WHERE rn = 1;

-- Department scorecard ---------------------------------------------------------
DROP TABLE IF EXISTS clean_department_scorecard;
CREATE TABLE clean_department_scorecard (
    department TEXT PRIMARY KEY,
    headcount INTEGER,
    turnover_rate REAL,
    absenteeism_rate REAL,
    engagement_score REAL,
    performance_score REAL,
    overtime_hours REAL,
    vacancy_days REAL,
    people_risk_index REAL,
    risk_band TEXT,
    priority_action TEXT
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY LOWER(TRIM(department))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_department_scorecard
    WHERE NULLIF(TRIM(department), '') IS NOT NULL
)
INSERT INTO clean_department_scorecard
SELECT
    TRIM(department),
    CAST(headcount AS INTEGER),
    CASE WHEN CAST(turnover_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(turnover_rate AS REAL) END,
    CASE WHEN CAST(absenteeism_rate AS REAL) BETWEEN 0 AND 1 THEN CAST(absenteeism_rate AS REAL) END,
    CASE WHEN CAST(engagement_score AS REAL) BETWEEN 0 AND 100 THEN CAST(engagement_score AS REAL) END,
    CASE WHEN CAST(performance_score AS REAL) BETWEEN 0 AND 100 THEN CAST(performance_score AS REAL) END,
    CASE WHEN CAST(overtime_hours AS REAL) >= 0 THEN CAST(overtime_hours AS REAL) END,
    CASE WHEN CAST(vacancy_days AS REAL) >= 0 THEN CAST(vacancy_days AS REAL) END,
    CASE WHEN CAST(people_risk_index AS REAL) BETWEEN 0 AND 100 THEN CAST(people_risk_index AS REAL) END,
    CASE
        WHEN LOWER(TRIM(risk_band)) = 'low' THEN 'Low'
        WHEN LOWER(TRIM(risk_band)) = 'medium' THEN 'Medium'
        WHEN LOWER(TRIM(risk_band)) = 'high' THEN 'High'
        ELSE 'Unclassified'
    END,
    NULLIF(TRIM(priority_action), '')
FROM ranked
WHERE rn = 1;

-- Intervention impact ----------------------------------------------------------
DROP TABLE IF EXISTS clean_intervention_impact;
CREATE TABLE clean_intervention_impact (
    strategy_area TEXT PRIMARY KEY,
    business_problem TEXT,
    intervention TEXT,
    baseline REAL,
    target REAL,
    actual REAL,
    owner TEXT,
    status TEXT
);

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY LOWER(TRIM(strategy_area))
               ORDER BY _source_row_id DESC
           ) AS rn
    FROM raw_intervention_impact
    WHERE NULLIF(TRIM(strategy_area), '') IS NOT NULL
)
INSERT INTO clean_intervention_impact
SELECT
    TRIM(strategy_area),
    NULLIF(TRIM(business_problem), ''),
    NULLIF(TRIM(intervention), ''),
    CAST(baseline AS REAL),
    CAST(target AS REAL),
    CAST(actual AS REAL),
    NULLIF(TRIM(owner), ''),
    CASE
        WHEN LOWER(TRIM(status)) = 'completed' THEN 'Completed'
        WHEN LOWER(TRIM(status)) IN ('in progress','in-progress') THEN 'In progress'
        WHEN LOWER(TRIM(status)) IN ('not started','not-started') THEN 'Not started'
        ELSE NULLIF(TRIM(status), '')
    END
FROM ranked
WHERE rn = 1;

-- Dictionary ------------------------------------------------------------------
DROP TABLE IF EXISTS clean_data_dictionary;
CREATE TABLE clean_data_dictionary AS
SELECT DISTINCT
    LOWER(TRIM(file)) AS file,
    LOWER(TRIM(field)) AS field,
    LOWER(TRIM(data_type)) AS data_type,
    TRIM(description) AS description
FROM raw_data_dictionary
WHERE NULLIF(TRIM(file), '') IS NOT NULL
  AND NULLIF(TRIM(field), '') IS NOT NULL;

-- Indexes ---------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_clean_employees_department
ON clean_employees(department);

CREATE INDEX IF NOT EXISTS idx_clean_employees_risk
ON clean_employees(risk_band);

CREATE INDEX IF NOT EXISTS idx_clean_recruitment_department
ON clean_recruitment(department);

CREATE INDEX IF NOT EXISTS idx_clean_learning_employee
ON clean_learning(employee_id);

CREATE INDEX IF NOT EXISTS idx_clean_department_month
ON clean_department_monthly_kpis(month, department);
