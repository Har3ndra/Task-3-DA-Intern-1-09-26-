# Task-3-DA-Intern-1-09-26-
# 🛒 E-Commerce SQL Data Analysis

## 📌 Project Overview

This project demonstrates how SQL can be used to analyze an e-commerce business and extract meaningful insights from transactional data.

The analysis covers customer behavior, order performance, product sales, revenue by category, and basic query optimization using indexes and `EXPLAIN`.

The project was created as part of a **SQL for Data Analysis** task and is designed to demonstrate practical SQL skills relevant to a **Data Analyst** role.

---

## 🎯 Objectives

* Analyze e-commerce orders and customer activity
* Calculate revenue and sales metrics
* Identify top-performing products and categories
* Practice different types of SQL joins
* Use subqueries for deeper analysis
* Create reusable SQL views
* Improve query performance using indexes
* Analyze query execution plans using `EXPLAIN`

---

## 🗂️ Database Structure

The database contains four main tables:

### `customers`

Contains customer information such as:

* Customer ID
* Customer Name
* City
* State
* Signup Date

### `products`

Contains product information such as:

* Product ID
* Product Name
* Category
* Price
* Stock

### `orders`

Contains order-level information:

* Order ID
* Customer ID
* Order Date
* Order Status

### `order_items`

Contains individual products included in each order:

* Order Item ID
* Order ID
* Product ID
* Quantity
* Unit Price

### 🔗 Relationships

```text
Customers
    │
    └── Orders
           │
           └── Order Items
                    │
                    └── Products
```

---

## 🛠️ Tools & Technologies

* **MySQL 8.0+**
* **MySQL Workbench**
* SQL

---

## 🔍 SQL Concepts Demonstrated

### Basic SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`

### Aggregate Functions

* `SUM()`
* `AVG()`
* `COUNT()`
* `COALESCE()`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`

### Advanced SQL

* Subqueries
* `HAVING`
* `CASE`
* `LIMIT`

### Database Objects

* SQL Views
* Indexes

### Query Optimization

* `EXPLAIN`
* Index-based query optimization

---

## 📊 Key Analysis

The project answers questions such as:

1. How many orders were delivered, shipped, or cancelled?
2. What is the total revenue generated?
3. Which customers have the highest spending?
4. Which products generate the most revenue?
5. Which product categories perform best?
6. Which customers spend above the average customer spending?
7. How can SQL views simplify recurring analysis?
8. How can indexes improve query performance?

---

## 📈 Key Insights

Based on the sample dataset:

* **Total revenue:** 53,557
* **Highest revenue category:** Fashion — 15,594
* **Second-highest revenue category:** Electronics — 14,289
* **Highest units sold by category:** Stationery — 12 units
* **Average order-line value:** approximately 2,434

> Note: Revenue calculations exclude cancelled orders.

---

## ⚡ Query Optimization

Indexes were created on frequently queried columns, including:

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(status);
```

`EXPLAIN` was then used to inspect the query execution plan and understand how MySQL accesses the data.

Example:

```sql
EXPLAIN
SELECT
    order_id,
    order_date,
    status
FROM orders
WHERE customer_id = 2
  AND order_date >= '2025-05-01'
ORDER BY order_date;
```

---

## 📁 Project Files

```text
Ecommerce-SQL-Data-Analysis/
│
├── Ecommerce_SQL_Analysis_MySQL.sql
└── README.md
```

The SQL file contains the complete database setup, sample data, analytical queries, views, indexes, and optimization queries.

---

## 🚀 How to Run the Project

### 1. Install MySQL

Make sure **MySQL 8.0+** and MySQL Workbench are installed.

### 2. Open the SQL file

Open:

```text
Ecommerce_SQL_Analysis_MySQL.sql
```

in MySQL Workbench.

### 3. Execute the script

Run the script using the **Execute ⚡** button.

The script will automatically:

* Create the `ecommerce_analysis` database
* Create the required tables
* Insert sample data
* Run analytical queries
* Create analytical views
* Create indexes
* Demonstrate `EXPLAIN`

### 4. Explore the results

Run the individual queries in MySQL Workbench and review the results in the Result Grid.

---

## 💡 Business Value

This project demonstrates how SQL can support business decision-making by transforming raw transactional data into useful information.

The analysis can help an e-commerce business understand:

* Revenue performance
* Customer spending behavior
* Product performance
* Category-level sales
* Order status distribution
* Opportunities for query and database optimization

---

## 👨‍💻 Author

**Harendra Singh Parihar**

Aspiring Data Analyst | SQL | Python | Excel | Tableau

---

⭐ If you found this project useful, feel free to explore the SQL queries and analysis.

