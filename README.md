# Retail Sales Analysis SQL Project

## Project Overview
This project demonstrates SQL skills in handling, exploring, and analyzing retail sales data. The dataset is sourced from an **Outsource** database and contains transactions, customer details, and product sales information. The objective is to clean the data, perform exploratory analysis, and extract meaningful insights to answer business-related questions.

## Database Setup
To create the database and table structure, run the following script:
```sql
-- Create Retail Sales Table
CREATE TABLE retail_sales_new (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

##  Data Exploration & Cleaning
To clean and explore the dataset, we check for missing values and inconsistencies:
```sql
-- Check for NULL values
SELECT * FROM retail_sales_new
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

## 📊 Business Analysis & Insights
This project answers key business questions, including:
1. Total number of sales transactions
2. Top-selling product categories
3. Average customer age by category
4. Monthly sales trends and best-performing months
5. Top 5 customers by total sales

The following SQL queries were developed to answer specific business questions:

**Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'**
```sql
SELECT *
FROM retail_sales_new
WHERE sale_date = '2022-11-05';
```

**Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**
```sql
SELECT 
  *
FROM retail_sales_new
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4 ;
```

**Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
SELECT category, 
	SUM(total_sale) as net_sale ,
	COUNT(*) as total_orders
FROM retail_sales_new
GROUP BY 1 ;
```

**Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT category, 
	ROUND(avg(age),2)  as avg_age
FROM retail_sales_new
WHERE category = 'Beauty' 
GROUP BY 1
```

**Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```sql
SELECT * FROM retail_sales_new
WHERE total_sale > 1000
```

**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**
```sql
SELECT category, gender,
COUNT(*) as total_trans
FROM retail_sales_new
GROUP BY category, gender 
ORDER BY 1;
```
**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**
```sql
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
```

**Q.8 Write a SQL query to find the top 5 customers based on the highest total sales**
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

**Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```
**Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

Example Query:
```sql
-- Find the top 5 customers based on total sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales_new
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```
Full analysis queries are in `sql_queries/business_analysis.sql`.

## 📈 Insights & Findings
Some key takeaways from this project:
- The most popular product category is **Clothing**.
- The **Afternoon shift** (12 PM - 5 PM) has the highest number of transactions.
- The best sales month in 2022 was **November**.

For more insights, check `reports/insights.md`.

## 🚀 How to Use This Project
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/Retail_Sales_SQL.git
   ```
2. Load the `schema.sql` into your SQL database.
3. Run the scripts in `sql_queries/` for data exploration and analysis.

## 📜 License
This project is licensed under the [MIT License](LICENSE).

## 🤝 Contributing
Contributions are welcome! If you find issues or have suggestions, feel free to open an issue or a pull request.

---
💡 *This project is part of my Data Analytics Portfolio. Feel free to explore and connect with me on [GitHub](https://github.com/yourusername).*

