-- Each core row should be kept exactly once after the join.
-- Recovery values for 2019 should be 1.0 for both UPT and VRH.
-- Nothing should be null, since the baseline month values are complete for 2019.
SELECT
    COUNT(*) AS n_rows,
    (
        SELECT
            COUNT (*)
        FROM
            core
    ) AS n_core_rows,
    SUM(
        CASE
            WHEN YEAR(month) = 2019
            AND (
                upt_recovery <> 1
                OR vrh_recovery <> 1
            ) THEN 1
            ELSE 0
        END
    ) AS bad_2019_rows,
    SUM(
        CASE
            WHEN upt_recovery IS NULL
            OR vrh_recovery IS NULL THEN 1
            ELSE 0
        END
    ) AS null_rows
FROM
    monthly_recovery;