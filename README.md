# TriMet Ridership Recovery Since 2019

How has TriMet ridership recovered since 2019, and how does recovery differ by mode?

This analysis covers TriMet's fixed-route bus and MAX light rail, which together make up over 98% of its ridership.

**Status:** In progress. Data acquired, validated, and cleaned; SQL analysis next.

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

**Processed data:** [`data/processed/trimet_monthly.csv`](data/processed/trimet_monthly.csv) has one row per mode, type of service, and month (506 rows, January 2019 to September 2026), with UPT and VRH side by side. It includes all active TriMet services. Bus and MAX were 98.7% of UPT in 2019 and 98.5% over October 2025 to September 2026. The analysis itself filters to bus and MAX.

| Column | Description |
|---|---|
| `month` | First day of the month |
| `mode`, `tos` | NTD mode and type of service (e.g. MB/DO) |
| `mode_name` | Readable mode name |
| `upt` | Unlinked passenger trips |
| `vrh` | Vehicle revenue hours |

## Metrics

| Metric | Definition |
|---|---|
| UPT | Unlinked passenger trips. Every boarding counts as one trip, so a transfer counts as two. |
| VRH | Vehicle revenue hours: hours vehicles are in service and available to the public. |
| Recovery % | A month's UPT divided by UPT for the same month in 2019. |
| Trips per revenue hour | Total UPT divided by total VRH (sums first, then the ratio). |

**Baseline:** the same calendar month in 2019, to account for seasonality.

## Data validation
I compared the FTA adjusted file against the raw file, because the adjusted file fills in missing recent values with growth-rate estimates. For UPT and VRH, January 2019 to September 2026, no TriMet values are estimates and none differ between the two files. See [`notebooks/01_estimates_check.ipynb`](notebooks/01_estimates_check.ipynb).

[`notebooks/02_clean_trimet.ipynb`](notebooks/02_clean_trimet.ipynb) adds checks on the cleaned data: no duplicate keys, no negative values, UPT and VRH present together, and complete months for bus and MAX.

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
3. Run the notebooks in `notebooks/` in numeric order.

## Project structure

```
data/raw/         Original NTD downloads (not committed)
data/processed/   Cleaned TriMet-only data (trimet_monthly.csv)
sql/              Analysis queries
notebooks/        Validation, cleaning, and charts
requirements.txt  Python dependencies
```

## Findings

*To be added.*