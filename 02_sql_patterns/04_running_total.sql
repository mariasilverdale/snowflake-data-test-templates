-- Running revenue by day
WITH daily AS (
  SELECT
    TO_DATE(ORDER_TS) AS order_day,
    SUM(QTY * UNIT_PRICE) AS revenue
  FROM SALES
  GROUP BY 1
)
SELECT
  order_day,
  revenue,
  SUM(revenue) OVER (ORDER BY order_day) AS running_revenue
FROM daily
ORDER BY order_day;
