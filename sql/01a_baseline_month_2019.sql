-- Month-of-year values from 2019 for baseline comparison.
CREATE
OR REPLACE VIEW baseline_month AS
SELECT
    mode,
    MONTH(month) AS month_num,
    upt AS baseline_upt,
    vrh AS baseline_vrh
FROM
    core
WHERE
    YEAR(month) = 2019;