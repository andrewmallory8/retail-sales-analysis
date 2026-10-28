# Retail Sales and Customer Analysis

**Business question:** What drives this store’s revenue, and how important are repeat customers?

## Open in VS Code

Open this folder or `retail-sales-analysis.code-workspace` in VS Code. Install the recommended **Python** and **Jupyter** extensions when prompted. Open `notebooks/retail_analysis.ipynb`, click **Select Kernel → Python Environments**, and choose `.venv/bin/python`.

## Environment

A local `.venv` is used for this project. To recreate it on macOS/Linux:

```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

On Windows, create the environment with `python -m venv .venv`, activate it with `.venv\Scripts\Activate.ps1`, and select `.venv\Scripts\python.exe` in VS Code.

## Dataset

Download **Online Retail.xlsx** from [UCI Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail), extract the download if needed, and place the Excel file in `data/raw/`. Raw data and generated outputs are excluded from Git.

## First session

Run the notebook to load the workbook, inspect the columns, and audit missing values, cancellations, nonpositive quantities/prices, duplicate rows, and month coverage. One row is an **invoice line**, not an order. Record cleaning decisions before producing results.

## Structure

- `data/raw/`: source workbook
- `data/processed/`: future cleaned data and SQLite database
- `notebooks/retail_analysis.ipynb`: starter inspection and audit
- `sql/analysis.sql`: starter queries for the future sales table
- `images/`: exported charts

## Planned metric definitions

Purchase sales will include positive quantities and prices and exclude cancellation invoices. Purchase revenue will not subtract returns; it is **not net revenue**. Orders use distinct invoice numbers. Customer metrics will exclude missing customer IDs. Repeat customers have at least two distinct purchase invoices during the observed period. Cohorts use first observed purchase month and must leave future, unobserved months blank.

## Findings and limitations

Analysis has not been run. Add three supported findings, charts, recommendations, cleaning decisions, and limitations after validation. Flag boundary months until calendar coverage has been reviewed; the data cannot establish a customer’s first-ever purchase or causal effects.
