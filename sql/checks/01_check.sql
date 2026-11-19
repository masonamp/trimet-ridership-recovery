-- Check baselines: each mode should have 12 baseline months,
-- and the monthly baselines should sum to the yearly baseline.
SELECT
    m.mode,
    COUNT(*) AS n_months,
    SUM(m.baseline_upt) = y.baseline_upt_year AS upt_match,
    SUM(m.baseline_vrh) = y.baseline_vrh_year AS vrh_match
FROM
    baseline_month AS m
    JOIN baseline_year AS y ON m.mode = y.mode
GROUP BY
    m.mode,
    y.baseline_upt_year,
    y.baseline_vrh_year
ORDER BY
    m.mode;