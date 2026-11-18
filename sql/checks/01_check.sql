-- Ensure that the sum of the baseline month values for 2019 matches the baseline year values for 2019.
SELECT
    m.mode,
    COUNT(*) AS n_months,
    SUM(m.baseline_upt) = y.baseline_upt_year AS upt_match,
    SUM(m.baseline_vrh) = y.baseline_vrh_year AS vrh_match
FROM
    baseline_month as m
    JOIN baseline_year as y ON m.mode = y.mode
GROUP BY
    m.mode,
    y.baseline_upt_year,
    y.baseline_vrh_year
ORDER BY
    m.mode