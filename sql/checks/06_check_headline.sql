-- Check the latest month (2026-09): rolling recovery and trips per revenue hour vs 2019.
-- Expect recovery below 1 and productivity below the 2019 level.
SELECT
    f.mode,
    f.month,
    ROUND(f.upt_recovery_rolling, 3) AS upt_recovery_rolling,
    ROUND(f.vrh_recovery_rolling, 3) AS vrh_recovery_rolling,
    ROUND(f.upt_per_vrh_rolling, 2) AS upt_per_vrh_rolling,
    ROUND(y.baseline_upt_year / y.baseline_vrh_year, 2) AS upt_per_vrh_2019
FROM
    final_table AS f
    JOIN baseline_year AS y ON f.mode = y.mode
WHERE
    f.month = (
        SELECT
            MAX(month)
        FROM
            final_table
    )
ORDER BY
    f.mode;