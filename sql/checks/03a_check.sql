-- Check rolling_12 (Sep 2026 data).
-- Expect 82 rows per mode, first month 2019-12, last month 2026-09.
-- December 2019 recovery should be 1.0, as that window is the baseline.
SELECT
    mode,
    COUNT(*) AS n_rows,
    MIN(month) AS first_month,
    MAX(month) AS last_month,
    ROUND(
        MAX(upt_recovery_rolling) FILTER (
            WHERE
                month = '2019-12-01'
        ),
        6
    ) AS dec_2019_upt_recovery,
    ROUND(
        MAX(vrh_recovery_rolling) FILTER (
            WHERE
                month = '2019-12-01'
        ),
        6
    ) AS dec_2019_vrh_recovery,
    COUNT_IF(
        upt_recovery_rolling IS NULL
        OR vrh_recovery_rolling IS NULL
    ) AS null_rows
FROM
    rolling_12
GROUP BY
    mode
ORDER BY
    mode;