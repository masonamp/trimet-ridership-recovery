-- rolling_12: trailing 12-month UPT and VRH totals, and each as a share of the calendar-2019 totals.
-- Grain: one row per mode per month, from 2019-12 on (earlier months lack a full window), 164 rows.
-- Ratios are raw (1.0 = same as 2019), not percentages.
-- Assumes no missing months in core; checks/03b verifies each window spans 12 calendar months.
-- Depends on: core, baseline_year.
CREATE
OR REPLACE VIEW rolling_12 AS WITH windowed AS (
    SELECT
        mode,
        mode_name,
        month,
        SUM(upt) OVER w AS upt_rolling,
        SUM(vrh) OVER w AS vrh_rolling,
        COUNT(*) OVER w AS months_in_window -- Count of months in the rolling window, to filter out incomplete windows
    FROM
        core WINDOW w AS (
            PARTITION BY mode
            ORDER BY
                month ROWS BETWEEN 11 PRECEDING
                AND CURRENT ROW
        )
)
SELECT
    w.mode,
    w.mode_name,
    w.month,
    w.upt_rolling,
    w.vrh_rolling,
    w.upt_rolling / y.baseline_upt_year AS upt_recovery_rolling,
    w.vrh_rolling / y.baseline_vrh_year AS vrh_recovery_rolling
FROM
    windowed AS w
    JOIN baseline_year AS y ON w.mode = y.mode
WHERE
    w.months_in_window = 12;