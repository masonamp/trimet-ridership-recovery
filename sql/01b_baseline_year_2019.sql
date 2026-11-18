-- Year sum value for 2019, used as a baseline for comparison for rolling windows.
CREATE
OR REPLACE VIEW baseline_year AS
SELECT
    mode,
    SUM(upt) AS baseline_upt_year,
    SUM(vrh) AS baseline_vrh_year
FROM
    core
WHERE
    YEAR(month) = 2019
GROUP BY
    mode;