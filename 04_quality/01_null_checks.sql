USE DATABASE TEST_DB;
USE SCHEMA PUBLIC;

-- Null profiling for SALES
SELECT
  COUNT(*) AS total_rows,

  SUM(IFF(ORDER_ID    IS NULL, 1, 0)) AS null_order_id,
  SUM(IFF(CUSTOMER_ID IS NULL, 1, 0)) AS null_customer_id,
  SUM(IFF(ORDER_TS    IS NULL, 1, 0)) AS null_order_ts,
  SUM(IFF(PRODUCT     IS NULL, 1, 0)) AS null_product,
  SUM(IFF(QTY         IS NULL, 1, 0)) AS null_qty,
  SUM(IFF(UNIT_PRICE  IS NULL, 1, 0)) AS null_unit_price,
  SUM(IFF(REGION      IS NULL, 1, 0)) AS null_region
FROM SALES;

-- Rows with ANY nulls (quick exception report)
SELECT *
FROM SALES
WHERE ORDER_ID IS NULL
   OR CUSTOMER_ID IS NULL
   OR ORDER_TS IS NULL
   OR PRODUCT IS NULL
   OR QTY IS NULL
   OR UNIT_PRICE IS NULL
   OR REGION IS NULL
LIMIT 100;
