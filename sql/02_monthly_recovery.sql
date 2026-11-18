-- Monthly_recovery view will hold each month's UPT and VRH values as a share of the same month-of-the-year in the 2019 baseline.
-- Recovery is stored as a raw ratio.
CREATE
OR REPLACE VIEW monthly_recovery AS
SELECT
    c.mode,
    c.mode_name,
    c.month,
    c.upt,
    c.vrh,
    c.upt / bm.baseline_upt AS upt_recovery,
    c.vrh / bm.baseline_vrh AS vrh_recovery
FROM
    core AS c
    JOIN baseline_month AS bm ON c.mode = bm.mode
    AND MONTH(c.month) = bm.month_num