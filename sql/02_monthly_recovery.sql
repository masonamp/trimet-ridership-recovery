-- monthly_recovery: each month's UPT and VRH as a share of the same month in 2019.
-- Grain: one row per mode per month, 186 rows.
-- Ratios are raw (1.0 = same as 2019), not percentages.
-- Single months are noisier than the rolling version (rolling_12).
-- Depends on: core, baseline_month (inner join; checks/02a confirms no rows are dropped).
CREATE
OR REPLACE VIEW monthly_recovery AS
SELECT
    c.mode,
    c.mode_name,
    c.month,
    c.upt,
    c.vrh,
    c.upt / m.baseline_upt AS upt_recovery_monthly,
    c.vrh / m.baseline_vrh AS vrh_recovery_monthly
FROM
    core AS c
    JOIN baseline_month AS m ON c.mode = m.mode
    AND MONTH(c.month) = m.month_num;