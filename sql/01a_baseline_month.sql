-- baseline_month: 2019 UPT and VRH for each month of the year, by mode.
-- Grain: one row per mode per month of year (month_num 1-12), 24 rows.
-- Used to compare each month with the same month in 2019 (monthly_recovery).
-- Depends on: core.
CREATE
OR REPLACE VIEW baseline_month AS
SELECT
    mode,
    MONTH(month) AS month_num,
    upt AS baseline_upt,
    vrh AS baseline_vrh
FROM
    core
WHERE
    YEAR(month) = 2019;