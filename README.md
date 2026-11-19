# TriMet Ridership Recovery Since 2019

How has TriMet ridership recovered since 2019, and how does recovery differ by mode?

This analysis covers TriMet's fixed-route bus and MAX light rail, which together make up over 98% of its ridership.

**Status:** In progress. Data acquired, validated, and cleaned; SQL analysis complete.

## Questions

1. How far has monthly ridership recovered relative to the same month in 2019, by mode?
2. Has ridership recovered faster or slower than service supply (revenue hours)?

## Data

- **Source:** FTA National Transit Database (NTD) monthly ridership data
- **Files used:**
  - [Complete Monthly Ridership (with adjustments and estimates)](https://www.transit.dot.gov/ntd/data-product/monthly-module-adjusted-data-release)
  - [Raw Monthly Ridership (no adjustments or estimates)](https://www.transit.dot.gov/ntd/data-product/monthly-module-raw-data-release)
- **Downloaded:** November 15, 2026
- **Coverage in files:** January 2002 to September 2026. This analysis uses January 2019 onward.
- **Agency:** Tri-County Metropolitan Transportation District of Oregon (TriMet)
- **Measures:** UPT (unlinked passenger trips) and VRH (vehicle revenue hours)

**Modes analyzed:**

| Mode | Type of service | Description |
|---|---|---|
| MB | DO | Fixed-route bus |
| LR | DO | MAX light rail |

TriMet's other reported services are excluded: demand-response (paratransit) and WES commuter rail (reported as hybrid rail) are small, structurally different services, and two older rows (CR, SR) have no data after 2012. Results describe bus and MAX, not all TriMet service.

### [`trimet_monthly.csv`](data/processed/trimet_monthly.csv)

One row per mode, type of service, and month (506 rows, January 2019 to September 2026), with UPT and VRH side by side. It includes all active TriMet services. Bus and MAX were 98.7% of UPT in 2019 and 98.5% over October 2025 to September 2026. The analysis itself filters to bus and MAX.

| Column | Description |
|---|---|
| `month` | First day of the month |
| `mode`, `tos` | NTD mode and type of service (e.g. MB/DO) |
| `mode_name` | Readable mode name |
| `upt` | Unlinked passenger trips |
| `vrh` | Vehicle revenue hours |

### [`recovery_monthly.csv`](data/processed/recovery_monthly.csv)

One row per mode (bus or MAX) per month, Jan 2019 to Sep 2026 (186 rows). Recovery values are raw ratios (1.0 = same as 2019). Rolling columns are empty before Dec 2019.

| Column | Meaning |
|---|---|
| `mode`, `mode_name` | MB (Bus) or LR (MAX light rail) |
| `month` | First day of the month |
| `upt`, `vrh` | Unlinked passenger trips and vehicle revenue hours |
| `upt_recovery_monthly`, `vrh_recovery_monthly` | Share of the same month in 2019 |
| `upt_rolling`, `vrh_rolling` | 12-month totals ending in this month |
| `upt_recovery_rolling`, `vrh_recovery_rolling` | 12-month totals as a share of the 2019 totals |
| `upt_per_vrh_monthly`, `upt_per_vrh_rolling` | Trips per revenue hour |

## Metrics

| Metric | Definition |
|---|---|
| UPT | Unlinked passenger trips. Every boarding counts as one trip, so a transfer counts as two. |
| VRH | Vehicle revenue hours: hours vehicles are in service and available to the public. |
| Monthly recovery | A month's UPT (or VRH) divided by UPT (or VRH) for the same month in 2019. Stored as a ratio (1.0 = same as 2019). |
| Rolling 12-month recovery | UPT (or VRH) summed over the 12 months ending in a month, divided by the 2019 calendar-year total. This removes seasonality. First available for Dec 2019. |
| Trips per revenue hour | Total UPT divided by total VRH (sums first, then the ratio). The rolling version uses the 12-month sums. |

**Baselines:** monthly recovery compares each month with the same calendar month in 2019, which accounts for seasonality. Rolling recovery compares 12-month totals with calendar-year 2019.

## Data validation

I compared the FTA adjusted file against the raw file, because the adjusted file fills in missing recent values with growth-rate estimates. For UPT and VRH, January 2019 to September 2026, no TriMet values are estimates and none differ between the two files. See [`notebooks/01_estimates_check.ipynb`](notebooks/01_estimates_check.ipynb).

[`notebooks/02_clean_trimet.ipynb`](notebooks/02_clean_trimet.ipynb) adds checks on the cleaned data: no duplicate keys, no negative values, UPT and VRH present together, and complete months for bus and MAX.

[`notebooks/03_sql_analysis.ipynb`](notebooks/03_sql_analysis.ipynb) checks each query's output (row counts, nulls, 2019 recovery equal to 1.0, values hand-checked against the source file) and recomputes the rolling 12-month values independently in pandas.

## Limitations

- UPT may be based on sampling rather than a full count, and FTA does not know which method each agency uses. Vehicle revenue hours must be 100% counts.
- Agencies can revise past figures, so results reflect the files on the date downloaded.
- UPT counts boardings, not people or complete journeys.
- The analysis covers fixed-route bus and MAX light rail only. Paratransit and WES are excluded, so figures do not represent all TriMet service.

## How to reproduce

1. Download both files from the links above and save them in `data/raw/` with these names:
   - `ntd_monthly_complete_2026-11-15.xlsx` (adjusted)
   - `ntd_monthly_raw_2026-11-15.xlsx` (raw)
2. Install dependencies: `pip install -r requirements.txt`
3. Run the notebooks in `notebooks/` in numeric order, from the repo root.

## Project structure

```
data/raw/         Original NTD downloads (not committed)
data/processed/   Cleaned TriMet data (trimet_monthly.csv) and analysis results (recovery_monthly.csv)
sql/              Analysis queries (DuckDB views, numbered in run order)
sql/checks/       Check queries
notebooks/        Validation, cleaning, SQL analysis, and charts
requirements.txt  Python dependencies
```

## Findings

*To be added.*