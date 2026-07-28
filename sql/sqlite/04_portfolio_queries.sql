-- BD HR Analytics — reusable portfolio queries
-- Compatible with SQLite and DBeaver's SQLite driver.

-- 1. Monthly executive trend
SELECT *
FROM vw_bi_monthly_hr_summary
ORDER BY month;

-- 2. Department risk ranking
SELECT
    department,
    people_risk_index,
    risk_band,
    turnover_rate,
    absenteeism_rate,
    engagement_score,
    priority_action
FROM vw_bi_department_scorecard
ORDER BY people_risk_index DESC, department;

-- 3. Recruitment source quality
SELECT
    source,
    SUM(applicants) AS applicants,
    SUM(joins) AS joins,
    ROUND(1.0 * SUM(joins) / NULLIF(SUM(applicants), 0), 4) AS applicant_to_join_rate,
    ROUND(AVG(avg_time_to_fill_days), 2) AS avg_time_to_fill_days,
    ROUND(AVG(avg_quality_of_hire_score), 2) AS avg_quality_of_hire_score,
    ROUND(AVG(avg_retention_90d_rate), 4) AS avg_retention_90d_rate
FROM vw_bi_recruitment_funnel
GROUP BY source
ORDER BY avg_quality_of_hire_score DESC;

-- 4. Learning programme impact
SELECT
    program,
    SUM(learning_records) AS learning_records,
    ROUND(AVG(completion_rate), 4) AS avg_completion_rate,
    ROUND(AVG(avg_score_improvement), 2) AS avg_score_improvement,
    ROUND(AVG(avg_behavior_application_score), 2) AS avg_behavior_application_score
FROM vw_bi_learning_impact
GROUP BY program
ORDER BY avg_score_improvement DESC;

-- 5. Aggregated workforce risk only
SELECT
    department,
    risk_band,
    employee_count,
    avg_people_risk_score,
    avg_engagement_score,
    avg_absence_rate,
    avg_monthly_overtime_hours
FROM vw_bi_employee_risk_summary
ORDER BY department,
         CASE risk_band WHEN 'High' THEN 1 WHEN 'Medium' THEN 2 WHEN 'Low' THEN 3 ELSE 4 END;

-- 6. Strategic intervention progress
SELECT
    strategy_area,
    baseline,
    target,
    actual,
    improvement_from_baseline,
    remaining_to_target,
    target_progress_rate,
    status
FROM vw_bi_intervention_progress
ORDER BY strategy_area;

-- 7. Data-quality review before dashboard refresh
SELECT *
FROM vw_data_quality_summary
ORDER BY issue_count DESC, source_table, field_name;
