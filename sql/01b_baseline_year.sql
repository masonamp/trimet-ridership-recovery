-- baseline_year: calendar-2019 total UPT and VRH, by mode.
-- Grain: one row per mode, 2 rows.
-- Used as the denominator for rolling 12-month recovery (rolling_12).
-- Depends on: core.
CREATE
OR REPLACE VIEW baseline_year AS
SELECT
    mode,
    SUM(upt) AS baseline_upt_year,
    SUM(vrh) AS baseline_vrh_year
FROM
    core
WHERE
    YEAR(month) = 2019
GROUP BY
    mode;