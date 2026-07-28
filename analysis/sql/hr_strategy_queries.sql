SELECT department, people_risk_index, risk_band FROM department_scorecard ORDER BY people_risk_index DESC;

SELECT phase, AVG(time_to_fill_days) AS avg_time_to_fill FROM recruitment GROUP BY phase;
