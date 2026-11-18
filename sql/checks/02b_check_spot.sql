-- Hand check a few values: edge cases and a pandemic month. 
SELECT
    mode,
    month,
    upt,
    vrh,
    ROUND(upt_recovery, 3) AS upt_recovery,
    ROUND(vrh_recovery, 3) AS vrh_recovery
FROM
    monthly_recovery
WHERE
    month IN ('2019-09-01', '2020-04-01', '2026-09-01')
ORDER BY
    mode,
    month;