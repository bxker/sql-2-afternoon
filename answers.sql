--Practice joins

--1
SELECT *
FROM invoice i
INNER JOIN invoice_line il 
ON i.invoice_id = il.invoice_id
WHERE il.unit_price > 0.99;

--2
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
INNER JOIN customer c
ON c.customer_id = i.customer_id;

--3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
INNER JOIN employee e
ON c.support_rep_id = e.employee_id;

--4
SELECT al.title, a.name
FROM album al
INNER JOIN artist a
ON al.artist_id = a.artist_id;

--5
SELECT pt.track_id
FROM playlist_track pt
INNER JOIN playlist p
ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

--6
SELECT t.name
FROM track t
INNER JOIN playlist_track pt
ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--7
SELECT t.name
FROM track t
INNER JOIN playlist_track pt
ON pt.track_id = t.track_id
INNER JOIN playlist p
ON pt.playlist_id = p.playlist_id;

--8
SELECT t.name, a.title
FROM track t
INNER JOIN album a
ON a.album_id = t.album_id
INNER JOIN genre g
ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

--black diamond
SELECT t.name, g.name, al.title, a.name, p.name
FROM track AS t
INNER JOIN playlist_track AS pt
ON t.track_id = pt.track_id
INNER JOIN playlist AS p
ON p.playlist_id = pt.playlist_id AND p.name = 'Music'
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
INNER JOIN album AS al
ON al.album_id = t.album_id
INNER JOIN artist AS a
ON a.artist_id = al.artist_id;


--Practice nested Queries

--1
SELECT *
FROM invoice 
WHERE invoice_id
IN 
(SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

--2
SELECT * 
FROM playlist_track
WHERE playlist_id
IN
(SELECT playlist_id FROM playlist WHERE name = 'Music');

--3
SELECT name 
FROM track
WHERE track_id
IN
(SELECT track_id FROM playlist_track WHERE playlist_id = 5);

--4
SELECT * 
FROM track
WHERE track_id
IN
(SELECT track_id FROM genre WHERE name = 'Comedy');

--5
SELECT * 
FROM track
WHERE track_id
IN
(SELECT track_id FROM album WHERE title = 'Fireball');

--6
SELECT * 
FROM track
WHERE album_id
IN
(SELECT album_id FROM album WHERE artist_id IN 
 	(SELECT artist_id from artist WHERE name = 'Queen'));

--black diamond


--Practice updating Rows

--1
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

--2
UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

--3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julie' AND last_name = 'Barnett';

--4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

--5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS NULL;

--6
--refreshed

--Group by

--1
SELECT COUNT(*), g.name
FROM track t
INNER JOIN genre g
ON t.genre_id = g.genre_id
GROUP BY g.name;

--2
SELECT COUNT(*), g.name
FROM track t
INNER JOIN genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

--3
SELECT COUNT(*), a.name
FROM album al
INNER JOIN artist a
ON a.artist_id = al.artist_id
GROUP BY a.name;


--Use Distinct

--1
SELECT DISTINCT composer
FROM track;

--2
SELECT DISTINCT billing_postal_code
FROM invoice;

--3
SELECT DISTINCT company		
FROM customer;


--Delete Rows

--1
--ran query

--2
DELETE
FROM practice_delete
WHERE type = 'bronze';

--3
DELETE
FROM practice_delete
WHERE type = 'silver';

--4
DELETE
FROM practice_delete
WHERE value = 150;

--Ecommerce No Hints

-- Create 3 tables following the criteria in the summary.
CREATE TABLE users(
	user_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL
);

CREATE TABLE products(
	product_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL
);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY NOT NULL,
  product_id INT,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Add some data to fill up each table.
    -- At least 3 users, 3 products, 3 orders.
INSERT INTO users
(name, email)
VALUES
('Jacob', 'email1@mail.com');

INSERT INTO users
(name, email)
VALUES
('Tramy', 'email2@mail.com');

INSERT INTO users
(name, email)
VALUES
('Rob', 'email3@mail.com');

INSERT INTO products
(name, price)
VALUES
('p1', 1);

INSERT INTO products
(name, price)
VALUES
('p2', 2);

INSERT INTO products
(name, price)
VALUES
('p3', 3);

INSERT INTO orders
(product_id)
VALUES
(1);

INSERT INTO orders
(product_id)
VALUES
(2);

INSERT INTO orders
(product_id)
VALUES
(3);

-- Run queries against your data.
    -- Get all products for the first order.
SELECT * 
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
WHERE o.order_id = 1;

    -- Get all orders.
SELECT * FROM orders;

    -- Get the total cost of an order ( sum the price of all products on an order ).
SELECT SUM(o.order_id)
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
WHERE o.order_id = 2;

-- Add a foreign key reference from orders to users.
-- ALTER TABLE orders
-- ADD COLUMN user_id INT
-- REFERENCES users(user_id);
ALTER TABLE users
ADD COLUMN order_id INT
REFERENCES orders(order_id);

-- Update the orders table to link a user to each order.

UPDATE users
SET order_id = 1
WHERE user_id = 1;

UPDATE users
SET order_id = 2
WHERE user_id = 2;

UPDATE users
SET order_id = 3
WHERE user_id = 3;

-- Run queries against your data.
    -- Get all orders for a user.
SELECT *
FROM users u
INNER JOIN orders o
ON o.order_id = u.order_id
WHERE u.user_id = 1;

    -- Get how many orders each user has.
SELECT COUNT(*)
FROM users u
INNER JOIN orders o
ON o.order_id = u.order_id
WHERE u.user_id = 1;

--black diamond
SELECT COUNT(*), u.name
FROM users u
INNER JOIN orders o
ON o.order_id = u.order_id
GROUP BY u.user_id;

