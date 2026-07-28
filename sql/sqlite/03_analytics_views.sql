-- BD HR Analytics — BI-ready and portfolio views
-- These views aggregate synthetic data for learning and dashboard use.
-- Individual risk scores must not be used for automated employment decisions.

DROP VIEW IF EXISTS vw_bi_monthly_hr_summary;
CREATE VIEW vw_bi_monthly_hr_summary AS
SELECT
    month,
    headcount,
    hires,
    exits,
    hires - exits AS net_headcount_change,
    annualized_turnover_rate,
    absenteeism_rate,
    overtime_cost_ratio,
    avg_engagement_score,
    avg_performance_score,
    avg_time_to_fill_days,
    training_completion_rate,
    compliance_documentation_rate,
    manager_effectiveness_score,
    early_attrition_90d_rate,
    phase
FROM clean_monthly_hr_kpis;

DROP VIEW IF EXISTS vw_bi_department_scorecard;
CREATE VIEW vw_bi_department_scorecard AS
SELECT
    department,
    headcount,
    turnover_rate,
    absenteeism_rate,
    engagement_score,
    performance_score,
    overtime_hours,
    vacancy_days,
    people_risk_index,
    risk_band,
    priority_action
FROM clean_department_scorecard;

DROP VIEW IF EXISTS vw_bi_recruitment_funnel;
CREATE VIEW vw_bi_recruitment_funnel AS
SELECT
    department,
    source,
    phase,
    SUM(applicants) AS applicants,
    SUM(interviews) AS interviews,
    SUM(offers) AS offers,
    SUM(joins) AS joins,
    ROUND(1.0 * SUM(interviews) / NULLIF(SUM(applicants), 0), 4) AS applicant_to_interview_rate,
    ROUND(1.0 * SUM(offers) / NULLIF(SUM(interviews), 0), 4) AS interview_to_offer_rate,
    ROUND(1.0 * SUM(joins) / NULLIF(SUM(offers), 0), 4) AS offer_to_join_rate,
    ROUND(AVG(time_to_fill_days), 2) AS avg_time_to_fill_days,
    ROUND(AVG(cost_per_hire_bdt), 2) AS avg_cost_per_hire_bdt,
    ROUND(AVG(quality_of_hire_score), 2) AS avg_quality_of_hire_score,
    ROUND(AVG(retention_90d_rate), 4) AS avg_retention_90d_rate
FROM clean_recruitment
GROUP BY department, source, phase;

DROP VIEW IF EXISTS vw_bi_learning_impact;
CREATE VIEW vw_bi_learning_impact AS
SELECT
    department,
    program,
    COUNT(*) AS learning_records,
    SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END) AS completed_records,
    ROUND(
        1.0 * SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        4
    ) AS completion_rate,
    ROUND(AVG(hours), 2) AS avg_hours,
    ROUND(AVG(pre_assessment_score), 2) AS avg_pre_score,
    ROUND(AVG(post_assessment_score), 2) AS avg_post_score,
    ROUND(AVG(post_assessment_score - pre_assessment_score), 2) AS avg_score_improvement,
    ROUND(AVG(behavior_application_score), 2) AS avg_behavior_application_score
FROM clean_learning
GROUP BY department, program;

DROP VIEW IF EXISTS vw_bi_employee_risk_summary;
CREATE VIEW vw_bi_employee_risk_summary AS
SELECT
    department,
    risk_band,
    COUNT(*) AS employee_count,
    ROUND(AVG(people_risk_score), 2) AS avg_people_risk_score,
    ROUND(AVG(engagement_score), 2) AS avg_engagement_score,
    ROUND(AVG(performance_score), 2) AS avg_performance_score,
    ROUND(AVG(absence_rate), 4) AS avg_absence_rate,
    ROUND(AVG(monthly_overtime_hours), 2) AS avg_monthly_overtime_hours
FROM clean_employees
GROUP BY department, risk_band;

DROP VIEW IF EXISTS vw_bi_intervention_progress;
CREATE VIEW vw_bi_intervention_progress AS
SELECT
    strategy_area,
    business_problem,
    intervention,
    baseline,
    target,
    actual,
    actual - baseline AS improvement_from_baseline,
    target - actual AS remaining_to_target,
    CASE
        WHEN target = baseline THEN NULL
        ELSE ROUND((actual - baseline) / (target - baseline), 4)
    END AS target_progress_rate,
    owner,
    status
FROM clean_intervention_impact;

DROP VIEW IF EXISTS vw_data_quality_summary;
CREATE VIEW vw_data_quality_summary AS
SELECT
    source_table,
    issue_type,
    field_name,
    COUNT(*) AS issue_count
FROM data_quality_issues
GROUP BY source_table, issue_type, field_name;
