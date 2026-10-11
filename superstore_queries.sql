USE superstore;

-- Q2. Products losing money
SELECT product_name, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit
FROM orders GROUP BY product_name HAVING SUM(profit) < 0
ORDER BY total_profit ASC LIMIT 20;

-- Q3. Discount vs profit
SELECT CASE WHEN discount = 0 THEN '0%' WHEN discount <= 0.2 THEN '1-20%'
            WHEN discount <= 0.4 THEN '21-40%' ELSE 'Over 40%' END AS discount_band,
       COUNT(*) AS order_lines, ROUND(SUM(profit),2) AS total_profit, ROUND(AVG(profit),2) AS avg_profit
FROM orders GROUP BY discount_band ORDER BY MIN(discount);

-- Q4. Monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       ROUND(SUM(sales),2) AS monthly_sales, ROUND(SUM(profit),2) AS monthly_profit
FROM orders GROUP BY month ORDER BY month;