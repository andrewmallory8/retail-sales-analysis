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
