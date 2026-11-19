-- Check monthly_recovery.
-- Each core row should be kept exactly once after the join.
-- Recovery values for 2019 should be 1.0 for both UPT and VRH.
-- Nothing should be null, since the baseline month values are complete for 2019.
SELECT
    COUNT(*) AS n_rows,
    (
        SELECT
            COUNT(*)
        FROM
            core
    ) AS n_core_rows,
    COUNT_IF(
        YEAR(month) = 2019
        AND (
            upt_recovery_monthly <> 1
            OR vrh_recovery_monthly <> 1
        )
    ) AS bad_2019_rows,
    COUNT_IF(
        upt_recovery_monthly IS NULL
        OR vrh_recovery_monthly IS NULL
    ) AS null_rows
FROM
    monthly_recovery;