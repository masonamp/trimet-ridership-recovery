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

### Modes analyzed

| Mode | Type of service | Description |
|---|---|---|
| MB | DO | Fixed-route bus |
| LR | DO | MAX light rail |

TriMet's other reported services are excluded: paratransit and WES commuter rail are small, differently structured services. There are also two older rows (CR and SR) that have no data after 2012. Results describe bus and MAX light rail only.

### [`trimet_monthly.csv`](data/processed/trimet_monthly.csv)

One row per mode, type of service, and month (506 rows, January 2019 to September 2026). UPT and VRH side by side. It includes all active TriMet services. Bus and MAX were 98.7% of UPT in 2019 and 98.5% over October 2025 to September 2026; the later analysis will filter to bus and MAX.

| Column | Description |
|---|---|
| `month` | First day of the month |
| `mode` | NTD mode code (e.g. MB for bus, LR for MAX light rail) |
| `tos` | NTD type of service code (e.g. DO) |
| `mode_name` | Readable mode name |
| `upt` | Unlinked passenger trips |
| `vrh` | Vehicle revenue hours |

### [`recovery_monthly.csv`](data/processed/recovery_monthly.csv)

One row per mode and month (186 rows, January 2019 to September 2026), for bus and MAX only. Recovery values are stored as ratios, not percentages. Rolling columns are empty before December 2019.

| Column | Description |
|---|---|
| `mode` | NTD mode code (e.g. MB for bus, LR for MAX light rail) |
| `mode_name` | Readable mode name |
| `month` | First day of the month |
| `upt` | Unlinked passenger trips |
| `vrh` | Vehicle revenue hours |
| `upt_recovery_monthly` | UPT as a share of the same month in 2019 |
| `vrh_recovery_monthly` | VRH as a share of the same month in 2019 |
| `upt_rolling` | UPT total for the 12 months ending in this month |
| `vrh_rolling` | VRH total for the 12 months ending in this month |
| `upt_recovery_rolling` | Rolling UPT total as a share of the 2019 calendar-year total |
| `vrh_recovery_rolling` | Rolling VRH total as a share of the 2019 calendar-year total |
| `upt_per_vrh_monthly` | Trips per revenue hour (UPT divided by VRH) for the month |
| `upt_per_vrh_rolling` | Trips per revenue hour over the 12 months ending in this month |

## Metrics

| Metric | Definition |
|---|---|
| UPT | Unlinked passenger trips |
| VRH | Vehicle revenue hours |
| Monthly recovery | A month's UPT or VRH divided by UPT or VRH for the same month in 2019 (stored as a ratio not percentage) |
| Rolling 12-month recovery | UPT or VRH summed over the 12 months ending in a month, divided by the 2019 calendar-year total to remove seasonality (first available for December 2019) |
| Trips per revenue hour | Total UPT divided by total VRH |

**Baselines:** monthly recovery compares each month with the same calendar month in 2019 to account for seasonality. Rolling recovery compares 12-month totals with calendar-year 2019.

## Data validation

[`notebooks/01_estimates_check.ipynb`](notebooks/01_estimates_check.ipynb) compares the FTA adjusted file against the raw file to ensure no values are estimates (the FTA file notes that some recent months can be growth rate estimates). For UPT and VRH, January 2019 to September 2026, no TriMet values are estimates and none differ between the two files.

[`notebooks/02_clean_trimet.ipynb`](notebooks/02_clean_trimet.ipynb) checks the cleaned data: no duplicate keys, no negative values, UPT and VRH present together, and complete months for bus and MAX.

[`notebooks/03_sql_analysis.ipynb`](notebooks/03_sql_analysis.ipynb) checks each query's output (row counts, nulls, 2019 recovery equal to 1.0, values hand-checked against the source file) and recomputes the rolling 12-month values independently in pandas.

## Limitations

- UPT may be based on sampling rather than a full count, but vehicle revenue hours are guaranteed to be 100% counts.
- Agencies can revise past figures, so results reflect the files on the date downloaded.
- UPT counts total boardings, not necessarily people/complete journeys.
- The analysis covers fixed-route bus and MAX light rail only (over 98% of ridership). Paratransit and WES are excluded.

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