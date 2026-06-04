create database OnlineStoreSystem;

USE OnlineStoreSystem;

CREATE TABLE products (
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(50) not null,
    category VARCHAR(30) not null,
    price DECIMAL(10,2) not null,
    stock INT not null
);

INSERT INTO products(name,category,price,stock) VALUES
( 'Laptop', 'Tech', 1500,20),
( 'Mouse', 'Tech', 20,100),
( 'Keyboard', 'Tech', 50,80),
('Shoes', 'Fashion', 80,170),
('T-Shirt', 'Fashion', 25,200);

CREATE TABLE users (
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(50) not null,
    country VARCHAR(30) not null
);

INSERT INTO users(name,country) VALUES
( 'Ali', 'Turkey'),
( 'Ayse', 'Germany'),
( 'Mehmet', 'Turkey'),
( 'Zeynep', 'France');

CREATE TABLE orders (
    id INT IDENTITY PRIMARY KEY,
    user_id INT not null,
    product_id INT not null,
    quantity INT not null,

    foreign key (user_id) references users(id),
    foreign key(product_id) references products(id)
);

INSERT INTO orders(user_id,product_id,quantity) VALUES
(1, 1, 1),
( 1, 2, 2),
( 2, 4, 1),
( 3, 3, 1),
( 3, 5, 3);

SELECT name,price 
FROM products;

SELECT *
FROM products
WHERE category LIKE 'Tech';

SELECT *
FROM users;

SELECT name,country
FROM users
WHERE country LIKE 'Turkey';

DELETE users
Where id>=5;

SELECT u.name,p.name,o.quantity,o.quantity*p.price as total_price
FROM users u JOIN orders o ON u.id=o.user_id JOIN products p ON o.product_id=p.id;

SELECT u.name , SUM(p.price*o.quantity) as total_spending
FROM orders o JOIN products p ON o.product_id=p.id JOIN users u ON u.id= o.user_id
GROUP BY u.name;

SELECT TOP 1 name,price
FROM products
ORDER BY price DESC;

SELECT TOP 3 name, stock
FROM products
ORDER BY stock DESC;

SELECT DISTINCT category
FROM products;

SELECT TOP 1 u.name,SUM(o.quantity*p.price) as total_spending
FROM users u INNER JOIN orders o ON u.id=o.user_id INNER JOIN products p ON o.product_id=p.id
GROUP BY u.name
ORDER BY total_spending DESC;

SELECT COUNT(*) AS product_count,AVG(price) AS avg_price
FROM products
WHERE category = 'Tech';

SELECT u.name, SUM(o.quantity*p.price) as total_spending
FROM users u JOIN orders o ON u.id=o.user_id JOIN products p on o.product_id=p.id
GROUP BY u.name
HAVING SUM(o.quantity*p.price)>100;