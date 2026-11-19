-- Spot check upt_per_vrh against hand-computed UPT / VRH:
-- 2019-09, 2019-12, 2020-04, 2026-09.
-- The rolling value is NULL for 2019-09 (no full window yet).
SELECT
    mode,
    month,
    ROUND(upt_per_vrh_monthly, 2) AS upt_per_vrh_monthly,
    ROUND(upt_per_vrh_rolling, 2) AS upt_per_vrh_rolling
FROM
    upt_per_vrh
WHERE
    month IN (
        '2019-09-01',
        '2019-12-01',
        '2020-04-01',
        '2026-09-01'
    )
ORDER BY
    mode,
    month;