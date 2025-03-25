-- 1. Database Setup
CREATE TABLE retail_sales_new
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantiy INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales_new

SELECT COUNT(*) FROM retail_sales_new;

--2. Data Exploration & Cleaning
SELECT * FROM retail_sales_new
where transactions_id is NULL
or sale_date is NULL
or sale_time is NULL
or customer_id is NULL
or gender is NULL
or age is NULL -- 10
or category is NULL

SELECT * FROM retail_sales_new
where quantity is NULL

ALTER TABLE retail_sales_new RENAME COLUMN quantiy TO quantity;

SELECT * FROM retail_sales_new
where quantity is NULL -- 3

SELECT * FROM retail_sales_new
where price_per_unit is NULL --3

SELECT * FROM retail_sales_new
where cogs is NULL --3

SELECT * FROM retail_sales_new
where customer_id  is NULL; --3


SELECT * FROM retail_sales_new
where transactions_id is NULL
or sale_date is NULL
or sale_time is NULL
or customer_id is NULL
or gender is NULL
or age is NULL -- 10
or category is NULL
or quantity is NULL -- 3
or price_per_unit is NULL --3
or cogs is NULL --3
or total_sale  is NULL; --3

SELECT COUNT(*) FROM retail_sales_new;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales_new;
SELECT DISTINCT category FROM retail_sales_new;

SELECT * FROM retail_sales_new
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE FROM retail_sales_new
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

SELECT * FROM retail_sales_new

-- DATA Exploration

-- How many sales we have ?
SELECT COUNT(*) AS total_sale FROM retail_sales_new

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales_new

-- 3. Data Analysis & Business Key Problems & Answers

-- MY ANALYSIS & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales_new
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales_new
WHERE category = 'Clothing'
  AND quantity >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';
--  
SELECT * 
FROM retail_sales_new
WHERE category = 'Clothing'
AND quantity >= 4
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, 
	SUM(total_sale) as net_sale ,
	COUNT(*) as total_orders
FROM retail_sales_new
GROUP BY 1 ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category, 
	ROUND(avg(age),2)  as avg_age
FROM retail_sales_new
WHERE category = 'Beauty' 
GROUP BY 1

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales_new
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender,
COUNT(*) as total_trans
FROM retail_sales_new
GROUP BY category, gender 
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR, MONTH, avg_sale
FROM (
    SELECT
        EXTRACT(Year FROM sale_date) as YEAR,
        EXTRACT(Month FROM sale_date) as MONTH,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(Year FROM sale_date) ORDER BY AVG(total_sale) DESC) as RANK
    FROM retail_sales_new
    GROUP BY 1, 2
) as t1
WHERE RANK = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
       SUM(total_sale) AS total_sale
FROM retail_sales_new
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, 
	count(DISTINCT customer_id) 
from retail_sales_new
GROUP BY 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT * ,
	CASE 
		when EXTRACT(HOUR FROM sale_time) < 12 then 'Morning'
		when EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 then 'Afternoon'
		else 'Evening'
	END as SHIFT
FROM retail_sales_new
)
SELECT
	shift,
	count(*) as total_order
FROM hourly_sale
GROUP BY 1

-- END OF PROJECT





