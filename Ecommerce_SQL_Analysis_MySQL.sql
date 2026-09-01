-- ============================================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- E-Commerce Sales Analysis
-- Database: MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- Clean setup
DROP VIEW IF EXISTS customer_order_summary;
DROP VIEW IF EXISTS product_sales_analysis;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- 2. INSERT SAMPLE E-COMMERCE DATA
-- ============================================================

INSERT INTO customers VALUES
(1,'Aarav Sharma','Jaipur','Rajasthan','2025-01-10'),
(2,'Priya Mehta','Delhi','Delhi','2025-01-15'),
(3,'Rohan Verma','Mumbai','Maharashtra','2025-02-02'),
(4,'Sneha Gupta','Jodhpur','Rajasthan','2025-02-18'),
(5,'Vikram Singh','Ahmedabad','Gujarat','2025-03-05'),
(6,'Neha Joshi','Pune','Maharashtra','2025-03-20'),
(7,'Karan Patel','Surat','Gujarat','2025-04-01'),
(8,'Ananya Rao','Bengaluru','Karnataka','2025-04-12');

INSERT INTO products VALUES
(101,'Wireless Mouse','Electronics',799.00,120),
(102,'Mechanical Keyboard','Electronics',2499.00,80),
(103,'USB-C Hub','Electronics',1499.00,60),
(104,'Running Shoes','Fashion',3299.00,45),
(105,'Backpack','Fashion',1899.00,70),
(106,'Coffee Maker','Home & Kitchen',4499.00,30),
(107,'Desk Lamp','Home & Kitchen',1299.00,90),
(108,'Water Bottle','Sports',699.00,150),
(109,'Yoga Mat','Sports',999.00,100),
(110,'Notebook','Stationery',299.00,200);

INSERT INTO orders VALUES
(1001,1,'2025-05-02','Delivered'),
(1002,2,'2025-05-03','Delivered'),
(1003,3,'2025-05-05','Delivered'),
(1004,4,'2025-05-08','Cancelled'),
(1005,5,'2025-05-10','Delivered'),
(1006,1,'2025-05-12','Delivered'),
(1007,6,'2025-05-15','Shipped'),
(1008,7,'2025-05-18','Delivered'),
(1009,8,'2025-05-20','Delivered'),
(1010,2,'2025-05-22','Delivered'),
(1011,3,'2025-05-25','Delivered'),
(1012,5,'2025-05-28','Shipped');

INSERT INTO order_items VALUES
(1,1001,101,2,799.00),
(2,1001,105,1,1899.00),
(3,1002,102,1,2499.00),
(4,1002,110,3,299.00),
(5,1003,106,1,4499.00),
(6,1003,107,2,1299.00),
(7,1004,104,1,3299.00),
(8,1005,108,4,699.00),
(9,1005,109,2,999.00),
(10,1006,103,1,1499.00),
(11,1006,101,1,799.00),
(12,1007,104,1,3299.00),
(13,1007,105,2,1899.00),
(14,1008,110,5,299.00),
(15,1008,107,1,1299.00),
(16,1009,102,1,2499.00),
(17,1009,103,2,1499.00),
(18,1010,106,1,4499.00),
(19,1010,108,2,699.00),
(20,1011,104,2,3299.00),
(21,1011,109,1,999.00),
(22,1012,101,3,799.00),
(23,1012,110,4,299.00);

-- ============================================================
-- 3. SELECT + WHERE + ORDER BY
-- ============================================================

SELECT order_id, customer_id, order_date, status
FROM orders
WHERE status = 'Delivered'
ORDER BY order_date DESC;

-- ============================================================
-- 4. GROUP BY + COUNT
-- ============================================================

SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- ============================================================
-- 5. AGGREGATE FUNCTIONS: SUM + AVG
-- ============================================================

SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    AVG(oi.quantity * oi.unit_price) AS average_line_value
FROM order_items oi
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled';

-- ============================================================
-- 6. INNER JOIN
-- ============================================================

SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- ============================================================
-- 7. LEFT JOIN
-- Shows all customers, including customers with no orders.
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC, c.customer_id;

-- ============================================================
-- 8. RIGHT JOIN
-- MySQL supports RIGHT JOIN.
-- Shows all customers even if an order-side match is absent.
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM orders o
RIGHT JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;

-- ============================================================
-- 9. SUBQUERY
-- Customers whose spending is above average customer spending.
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            o2.customer_id,
            SUM(oi2.quantity * oi2.unit_price) AS customer_total
        FROM orders o2
        INNER JOIN order_items oi2
            ON o2.order_id = oi2.order_id
        WHERE o2.status <> 'Cancelled'
        GROUP BY o2.customer_id
    ) AS customer_totals
)
ORDER BY total_spend DESC;

-- ============================================================
-- 10. TOP 5 PRODUCTS BY REVENUE
-- ============================================================

SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- ============================================================
-- 11. CATEGORY-LEVEL SALES ANALYSIS
-- ============================================================

SELECT
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    ROUND(AVG(oi.unit_price), 2) AS avg_selling_price
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY p.category
ORDER BY revenue DESC;

-- ============================================================
-- 12. CREATE VIEW: CUSTOMER ANALYSIS
-- ============================================================

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(
        SUM(
            CASE
                WHEN o.status <> 'Cancelled'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ), 0
    ) AS total_spend
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.city,
    c.state;

SELECT *
FROM customer_order_summary
ORDER BY total_spend DESC;

-- ============================================================
-- 13. CREATE VIEW: PRODUCT SALES ANALYSIS
-- ============================================================

CREATE VIEW product_sales_analysis AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(
        CASE
            WHEN o.status <> 'Cancelled' THEN oi.quantity
            ELSE 0
        END
    ), 0) AS units_sold,
    COALESCE(SUM(
        CASE
            WHEN o.status <> 'Cancelled'
            THEN oi.quantity * oi.unit_price
            ELSE 0
        END
    ), 0) AS revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name, p.category;

SELECT *
FROM product_sales_analysis
ORDER BY revenue DESC;

-- ============================================================
-- 14. INDEXES FOR QUERY OPTIMIZATION
-- ============================================================

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(status);

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_products_category
ON products(category);

-- ============================================================
-- 15. EXPLAIN: CHECK QUERY EXECUTION PLAN
-- ============================================================

EXPLAIN
SELECT
    o.order_id,
    o.order_date,
    o.status
FROM orders o
WHERE o.customer_id = 2
  AND o.order_date >= '2025-05-01'
ORDER BY o.order_date;

-- ============================================================
-- END OF PROJECT
-- ============================================================
