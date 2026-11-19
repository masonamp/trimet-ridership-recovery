-- upt_per_vrh: trips per revenue hour (UPT / VRH), monthly and rolling 12-month.
-- Grain: one row per mode per month, 186 rows.
-- Rolling = total UPT / total VRH over the window, not an average of monthly ratios.
-- Rolling values are NULL before 2019-12, when no full window exists.
-- Depends on: core, rolling_12 (left join).
CREATE
OR REPLACE VIEW upt_per_vrh AS
SELECT
    c.mode,
    c.month,
    c.upt / c.vrh AS upt_per_vrh_monthly,
    r.upt_rolling / r.vrh_rolling AS upt_per_vrh_rolling
FROM
    core AS c
    LEFT JOIN rolling_12 AS r ON c.mode = r.mode
    AND c.month = r.month;