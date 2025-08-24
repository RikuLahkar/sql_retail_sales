CREATE DATABASE IF NOT EXISTS sql_project;

USE sql_project;
CREATE TABLE retail(
	transactions_id	INT PRIMARY KEY,
    sale_date	DATE,
    sale_time	TIME,
    customer_id	INT,
    gender	VARCHAR(10),
    age	INT,
    category VARCHAR(50),	
    quantiy	INT,
    price_per_unit INT,	
    cogs	INT,
    total_sale FLOAT

);
SELECT * FROM retail;


SELECT COUNT(*) FROM retail;

-- DATA CLEANING
SELECT * FROM retail
WHERE
	transactions_id	IS NULL
    OR
    sale_date	IS NULL
    OR
    sale_time	IS NULL
    OR
    customer_id	IS NULL
    OR
    gender	IS NULL
    OR
    age	IS NULL
    OR
    category IS NULL
    OR
	quantiy	IS NULL
    OR
    price_per_unit IS NULL
    OR
	cogs IS NULL
    OR
    total_sale IS NULL;
    
DELETE FROM retail
WHERE
	transactions_id	IS NULL
    OR
    sale_date	IS NULL
    OR
    sale_time	IS NULL
    OR
    customer_id	IS NULL
    OR
    gender	IS NULL
    OR
    age	IS NULL
    OR
    category IS NULL
    OR
	quantiy	IS NULL
    OR
    price_per_unit IS NULL
    OR
	cogs IS NULL
    OR
    total_sale IS NULL;
    
-- DATA  EXPLORATION. HOW MANY SALES WE HAVE?????

SELECT COUNT(*) AS total_sale FROM retail

-- No. OF CUSTOMERS ALL TIME AND UNIQUE
SELECT COUNT( customer_id) AS total_sale FROM retail

-- unique that is unique id wnique sale
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail

SELECT COUNT( category) AS total_sale FROM retail

SELECT COUNT(DISTINCT category) AS total_sale FROM retail
-- types of category
SELECT DISTINCT category FROM retail

-- Data Analysis From Here 

-- Q1) WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"
SELECT * 
FROM retail 
WHERE sale_date = '2022-11-05';

-- Q2) WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS MORE THAN 2 IN MONTH OF NOV-2022
SELECT * 
FROM retail
WHERE category = 'Clothing'
  AND 
  DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND
  quantiy > 2
  
-- Q3)   WRITE A SQL QUERY TO CLACULATE THE TOTAL SALES(total_salr) FOR EACH CATEGORY
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail
GROUP BY category;

-- Q4) WRITE A SQL QUERY TO FIND AVG AGE OF CUSTOMERS WHO BOUGHT BAUTY ITEMS
  SELECT
	age
    FROM retail
    WHERE category = "Beauty"
 
 
 
 SELECT
	AVG(age) AS avg_age 
    FROM retail
    WHERE category = "Beauty"
-- Q5) WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL SALE IS GREATER THAN 1000 

SELECT * FROM retail
WHERE total_sale > 1000   

-- Q6) WRITE A SQL QUERY TO FIND TOTAL NO. OF TRANSACTONS(transaction_id) MADE BY EACH GENDER IN EACH CATEGORY
    
SELECT 
	category,
    gender,
    COUNT(*) AS total_transaction
FROM retail
GROUP BY category,gender
ORDER BY category,gender;

-- Q7) WRITE A SQL QUERY TO CALCULATE THE AVG SALE FOR EACH MONTH.FIND OUT  BEST SELLING MONTH IN EACH YEAR
SELECT  
	EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM retail
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
ORDER BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date);

--  Q8) FIND THE TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES MADE
SELECT
	customer_id,
	SUM(total_sale) AS total_sales
FROM retail
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9) WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASES ITEMS FROM EACH CATEGORY
SELECT
	category,
    COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMER
FROM retail
GROUP BY category;

-- Q10) WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS(eg Morning<=12, Afternoon betn 12 & 17, EVENING>=17)
WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Evening' 
        ELSE 'Evening'
        END AS shift
FROM retail
)
SELECT 
	shift,
	COUNT(*) AS total_orders

FROM hourly_sales
GROUP BY shift;        

  


 



    






