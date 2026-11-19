-- Check final_table: one row per mode per month.
-- Expect 186 rows and 186 unique keys, and NULL
-- rolling values only before 2019-12 (22 rows, 11 per mode).
SELECT
    COUNT(*) AS n_rows,
    COUNT(DISTINCT (mode, month)) AS n_unique_keys,
    COUNT_IF(
        upt_recovery_monthly IS NULL
        OR upt_per_vrh_monthly IS NULL
    ) AS null_monthly,
    COUNT_IF(upt_recovery_rolling IS NULL) AS null_rolling,
    COUNT_IF(
        upt_recovery_rolling IS NULL
        AND month >= '2019-12-01'
    ) AS unexpected_null_rolling
FROM
    final_table;