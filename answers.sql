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
