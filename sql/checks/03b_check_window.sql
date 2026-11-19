-- Check that each rolling window covers 12 calendar months (no gaps).
-- Windows are 12 rows, so this confirms 12 rows = 12 months.
-- Expect windows_checked 164 and bad_windows 0.
WITH w AS (
    SELECT
        month,
        MIN(month) OVER (
            PARTITION BY mode
            ORDER BY
                month ROWS BETWEEN 11 PRECEDING
                AND CURRENT ROW
        ) AS window_start
    FROM
        core
)
SELECT
    COUNT(*) AS windows_checked,
    COUNT_IF(DATEDIFF('month', window_start, month) <> 11) AS bad_windows
FROM
    w
WHERE
    month >= '2019-12-01';