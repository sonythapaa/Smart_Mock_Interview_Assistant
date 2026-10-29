# Data

This folder stores the raw, interim, and processed datasets used by the Smart Mock Interview Assistant.

| Folder | Purpose |
|---|---|
| `raw/` | Original source snapshots and source notes. These files should remain unchanged. |
| `interim/` | Intermediate transformed records produced by the preprocessing pipeline. |
| `processed/` | Cleaned question-bank files used by the application and EDA notebook. |

Main processed files:

- `processed/questions_cleaned.json`
- `processed/questions_cleaned.csv`
- `processed/questions.csv`

The runtime application reads `processed/questions_cleaned.json`. The CSV files provide spreadsheet-friendly versions of the same cleaned question bank.
