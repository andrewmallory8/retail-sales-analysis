-- Run after the cleaned purchase sales table has been created.
-- Purchase revenue excludes cancellations and nonpositive quantities/prices;
-- it does not subtract returns and is not net revenue.
SELECT COUNT(DISTINCT InvoiceNo) AS orders,
       SUM(LineRevenue) AS purchase_revenue,
       SUM(LineRevenue) / NULLIF(COUNT(DISTINCT InvoiceNo), 0) AS average_order_value
FROM sales;

SELECT InvoiceMonth, SUM(LineRevenue) AS purchase_revenue,
       COUNT(DISTINCT InvoiceNo) AS orders
FROM sales
GROUP BY InvoiceMonth
ORDER BY InvoiceMonth;

-- Product revenue and units, with a representative description.
WITH product_totals AS (
    SELECT StockCode,
           SUM(LineRevenue) AS purchase_revenue,
           SUM(Quantity) AS units,
           COUNT(DISTINCT InvoiceNo) AS orders
    FROM sales
    GROUP BY StockCode
), description_counts AS (
    SELECT StockCode, TRIM(Description) AS description, COUNT(*) AS occurrences
    FROM sales
    WHERE Description IS NOT NULL AND TRIM(Description) <> ''
    GROUP BY StockCode, TRIM(Description)
), ranked_descriptions AS (
    SELECT StockCode, description,
           ROW_NUMBER() OVER (
               PARTITION BY StockCode ORDER BY occurrences DESC, description
           ) AS rank
    FROM description_counts
)
SELECT p.StockCode, COALESCE(d.description, '(Description missing)') AS description,
       p.purchase_revenue, p.units, p.orders
FROM product_totals p
LEFT JOIN ranked_descriptions d ON p.StockCode = d.StockCode AND d.rank = 1
ORDER BY p.purchase_revenue DESC, p.StockCode;

-- Sales by country
SELECT COALESCE(Country, '(Country missing)') AS country,
       SUM(LineRevenue) AS purchase_revenue,
       COUNT(DISTINCT InvoiceNo) AS orders,
       SUM(Quantity) AS units
FROM sales
GROUP BY Country
ORDER BY purchase_revenue DESC, country;

-- Repeat customer contribution: identified customers only.
WITH customer_summary AS (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders,
           SUM(LineRevenue) AS purchase_revenue
    FROM sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT CASE WHEN orders >= 2 THEN 'Repeat' ELSE 'One purchase' END AS customer_type,
       COUNT(*) AS customers, SUM(orders) AS orders,
       SUM(purchase_revenue) AS purchase_revenue
FROM customer_summary
GROUP BY customer_type
ORDER BY customer_type;
