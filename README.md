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

