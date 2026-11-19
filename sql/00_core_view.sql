-- core: bus (MB) and MAX light rail (LR) only. Base for all later views.
-- Grain: one row per mode per month, 186 rows. Both modes have a single type of service (DO).
-- Depends on: monthly (loaded from data/processed/trimet_monthly.csv).
CREATE
OR REPLACE VIEW core AS
SELECT
    mode,
    mode_name,
    month,
    upt,
    vrh
FROM
    monthly
WHERE
    mode IN ('MB', 'LR');