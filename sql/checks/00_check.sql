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
    mode