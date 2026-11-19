-- Spot check monthly_recovery against hand-computed values from the source file:
-- 2019-09 (baseline, should be 1.0), 2020-04 (pandemic low), 2026-09 (latest month).
SELECT
    mode,
    month,
    upt,
    vrh,
    ROUND(upt_recovery_monthly, 3) AS upt_recovery_monthly,
    ROUND(vrh_recovery_monthly, 3) AS vrh_recovery_monthly
FROM
    monthly_recovery
WHERE
    month IN ('2019-09-01', '2020-04-01', '2026-09-01')
ORDER BY
    mode,
    month;