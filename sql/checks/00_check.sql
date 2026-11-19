-- Check core: expect 93 rows and 93 distinct months per mode, 2019-01 to 2026-09 (Sep 2026 data).
-- Catches duplicate or missing months.
SELECT
    mode,
    COUNT(*) AS n_rows,
    COUNT(DISTINCT month) AS n_distinct_months,
    MIN(month) AS first_month,
    MAX(month) AS last_month
FROM
    core
GROUP BY
    mode
ORDER BY
    mode;