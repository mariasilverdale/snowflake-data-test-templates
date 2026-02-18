USE DATABASE TEST_DB;
USE SCHEMA PUBLIC;

-- Second highest UNIT_PRICE overall (classic)
SELECT MAX(UNIT_PRICE) AS second_highest_unit_price
FROM SALES
WHERE UNIT_PRICE < (SELECT MAX(UNIT_PRICE) FROM SALES);

-- Alternative: using DENSE_RANK (handles ties cleanly)
WITH ranked AS (
  SELECT
    UNIT_PRICE,
    DENSE_RANK() OVER (ORDER BY UNIT_PRICE DESC) AS rnk
  FROM SALES
)
SELECT MAX(UNIT_PRICE) AS second_highest_unit_price
FROM ranked
WHERE rnk = 2;

-- Second highest per REGION (common real-world extension)
WITH ranked AS (
  SELECT
    REGION,
    UNIT_PRICE,
    DENSE_RANK() OVER (PARTITION BY REGION ORDER BY UNIT_PRICE DESC) AS rnk
  FROM SALES
)
SELECT
  REGION,
  MAX(UNIT_PRICE) AS second_highest_unit_price
FROM ranked
WHERE rnk = 2
GROUP BY REGION
ORDER BY REGION;
