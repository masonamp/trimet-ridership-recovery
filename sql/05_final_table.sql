-- final_table: all measures in one table, ready for export and Tableau.
-- Grain: one row per mode per month, 186 rows.
-- Columns: UPT, VRH, monthly recovery, rolling 12-month totals and recovery,
-- trips per revenue hour (monthly and rolling).
-- Recovery columns are raw ratios (1.0 = same as 2019), not percentages.
-- Rolling columns are NULL before 2019-12 (22 rows, 11 per mode); the left joins keep those months.
-- Depends on: core, monthly_recovery, rolling_12, upt_per_vrh.
CREATE
OR REPLACE VIEW final_table AS
SELECT
    c.mode,
    c.mode_name,
    c.month,
    c.upt,
    c.vrh,
    mr.upt_recovery_monthly,
    mr.vrh_recovery_monthly,
    r.upt_rolling,
    r.vrh_rolling,
    r.upt_recovery_rolling,
    r.vrh_recovery_rolling,
    uv.upt_per_vrh_monthly,
    uv.upt_per_vrh_rolling
FROM
    core AS c
    LEFT JOIN monthly_recovery AS mr ON c.mode = mr.mode
    AND c.month = mr.month
    LEFT JOIN rolling_12 AS r ON c.mode = r.mode
    AND c.month = r.month
    LEFT JOIN upt_per_vrh AS uv ON c.mode = uv.mode
    AND c.month = uv.month;