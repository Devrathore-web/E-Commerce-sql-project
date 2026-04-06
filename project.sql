------E-Commerce Database System------

---Project Goal---

-- Create a online shopping system--
--1. Users
--2. Products
--3. Orders
--4. Payments


-- Table Design --


-- 1. Users Table
Create Table users (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(100),
	city VARCHAR(50)
);


-- Users Data
INSERT INTO users (name, email, city) VALUES
('Dev Rathore', 'devrathore0205@gmail.com', 'Delhi'),
('Rohit Sharma', 'rohit@gmail.com', 'Mumbai'),
('Neha Verma', 'neha@gmail.com', 'Delhi'),
('Priya Patel', 'priya@gmail.com', 'Ahmedabad'),
('Karan Mehta', 'karan@gmail.com', 'Pune'),
('Anjali Gupta', 'anjali@gmail.com', 'Lucknow'),
('Vikas Yadav', 'vikas@gmail.com', 'Patna'),
('Sneha Sharma', 'sneha@gmail.com', 'Jaipur'),
('Rahul Das', 'rahul@gmail.com', 'Kolkata'),
('Pooja Singh', 'pooja@gmail.com', 'Chandigarh');


-- 2. Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price INT,
    category VARCHAR(50)
);

-- Products data
INSERT INTO products (product_name, price, category) VALUES
('Laptop', 60000, 'Electronics'),
('Mobile', 20000, 'Electronics'),
('Headphones', 2000, 'Electronics'),
('Shoes', 3000, 'Fashion'),
('T-shirt', 1000, 'Fashion'),
('Watch', 5000, 'Accessories'),
('Bag', 2500, 'Accessories'),
('Keyboard', 1500, 'Electronics'),
('Mouse', 800, 'Electronics'),
('Jeans', 2000, 'Fashion');


-- 3. Orders Table
Create Table orders (
	order_id SERIAL PRIMARY KEY,
	user_id INT,
	order_date DATE,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--Orders Data
INSERT INTO orders (user_id, order_date) VALUES
(1,'2024-01-01'),
(2,'2024-01-02'),
(3,'2024-01-03'),
(4,'2024-01-04'),
(5,'2024-01-05'),
(6,'2024-01-06'),
(7,'2024-01-07'),
(8,'2024-01-08'),
(9,'2024-01-09'),
(10,'2024-01-10');


-- 4. Order_Items Table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Order Items Data
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,1,1),(1,3,2),
(2,2,1),(2,5,3),
(3,4,2),(3,6,1),
(4,1,1),(4,7,2),
(5,8,1),(5,9,2),
(6,3,1),(6,10,2),
(7,2,1),(7,4,1),
(8,5,2),(8,6,1),
(9,7,1),(9,8,2),
(10,9,1),(10,10,2);


-- 5. Payments table 
Create Table payments (
	payment_id SERIAL PRIMARY KEY,
	order_id INT,
	amount INT,
	payment_method VARCHAR(50),
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Payments Data
INSERT INTO payments (order_id, amount, payment_method) VALUES
(1,64000,'UPI'),
(2,23000,'Card'),
(3,7000,'Cash'),
(4,65000,'UPI'),
(5,2300,'Card'),
(6,5000,'UPI'),
(7,23000,'Cash'),
(8,7000,'Card'),
(9,4000,'UPI'),
(10,3000,'Cash');



-------- TEST-------
SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;


---------- Advanced Concepts -------------
*  Multiple JOIN (4-5 Tables)
*  Real business logic 
*  Revenue calculation
*  Top customers analysis

---------------- Queries ------------------

-- 1. Show all users' names and their cities
SELECT name, city FROM users;

-- 2. Show products that belong to the Electronics category
SELECT * FROM products WHERE category = 'Electronics';

-- 3. Show products with price greater than 2000
SELECT * FROM products WHERE price > 2000;

-- 4. Show total number of orders
SELECT COUNT(*) FROM orders;

-- 5. Show how many unique cities are there
SELECT COUNT(DISTINCT city) FROM users;

-- 6. Show number of users in each city
SELECT city, COUNT(*) FROM users GROUP BY city;

-- 7. Show average product price
SELECT AVG(price) FROM products;

-- 8. Show maximum and minimum price
SELECT MAX(price), MIN(price) FROM products;

-- 9. Show number of products in each category
SELECT category, COUNT(*) FROM products GROUP BY category;

-- 10. Show top 5 most expensive products
SELECT * FROM products ORDER BY price DESC LIMIT 5;

-- 11. Show user name and order date
SELECT u.name, o.order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id;

-- 12. Show order ID, product name, and quantity
SELECT o.order_id, p.product_name, oi.quantity
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 13. Show user name and product name
SELECT u.name, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 14. Show total revenue
SELECT SUM(amount) FROM payments;

-- 15. Show how much each user has spent
SELECT u.name, SUM(p.amount)
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY u.name;

-- 16. Show the user who spent the most (Top Customer)
SELECT u.name, SUM(p.amount) AS total
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY u.name
ORDER BY total DESC
LIMIT 1;

-- 17. Show the most sold product
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;
