-- This core view will be used for all subsequent analysis and include only bus and light rail.
-- Both MB and LR are the same TOS (DO), so there is only one row per mode per month.
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