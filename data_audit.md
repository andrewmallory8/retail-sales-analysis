# Source-data audit

The source contains **541,909 invoice lines** and eight columns, dated **1 December 2010 to 9 December 2011**. Invoice lines are not orders.

| Issue | Affected rows | Decision for the next analysis stage |
|---|---:|---|
| Missing customer ID | 135,080 | Preserve for overall purchase sales; exclude from customer metrics |
| Missing description | 1,454 | Preserve; use StockCode for product grouping and inspect labels |
| Cancellation invoice | 9,288 | Preserve in raw data; exclude from purchase sales and review separately |
| Quantity at or below zero | 10,624 | Preserve in raw data; exclude from positive purchase sales; investigate returns and adjustments |
| Unit price at or below zero | 2,517 | Preserve in raw data; exclude from purchase sales; inspect free items and adjustments |
| Exact duplicate rows | 5,268 | Flag and retain pending evidence; identical lines may be legitimate, so do not automatically drop |

Counts overlap. No rows have been removed. **December 2011 is a partial month** and should be labelled or excluded from full-month comparisons. A lack of transactions on individual days does not prove that a month is incomplete; December 2010 ends on 23 December and requires calendar context before interpreting it.

Next: build the positive purchase-sales dataset, load SQLite, and validate totals before drawing business conclusions. Purchase revenue will not subtract returns and cancellations, so it must not be labelled net revenue.
