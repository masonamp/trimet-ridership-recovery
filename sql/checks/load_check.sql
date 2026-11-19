-- Months per mode and type of service in the loaded table.
SELECT
    mode,
    tos,
    COUNT(*) AS n_months,
    MIN(month) AS first_month,
    MAX(month) AS last_month
FROM
    monthly
GROUP BY
    mode,
    tos
ORDER BY
    mode,
    tos;