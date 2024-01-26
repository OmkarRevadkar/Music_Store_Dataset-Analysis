-- create database music_store;

use music_store;

-- 1) Who is the senior most employee based on job title?
select * from employee;
select employee_id, first_name, last_name, title, levels, hire_date from employee order by levels desc limit 1;


-- 2) Which countries have the most invoices?
select * from invoice;
select billing_country, count(*) as count_of_invoices from invoice group by billing_country order by count_of_invoices desc;


-- 3) What are top 3 values of total invoice?
select * from invoice;
select billing_country, sum(total) as total_invoice from invoice group by billing_country order by total_invoice desc limit 3;



-- 4) Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.
select * from invoice;
select billing_city, sum(total) as invoice_total from invoice group by billing_city order by invoice_total desc limit 1;



-- 5) Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.
select * from customer;
select * from invoice;

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total from customer join invoice 
ON customer.customer_id  = invoice.customer_id 
group by customer.customer_id, customer.last_name,customer.first_name
order by total desc limit 1;


-- 6. Write a query to return the email, first name, last name & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A. 
select DISTINCT email, first_name, last_name from customer 
JOIN invoice
ON customer.customer_id = invoice.customer_id 
JOIN invoice_line 
ON invoice_line.invoice_id = invoice.invoice_id 
WHERE track_id IN (select track_id from track JOIN genre ON genre.genre_id = track.genre_id WHERE genre.name like 'Rock')
order by email;



-- 7. Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands. 
select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album2 on album2.album_id = track.album_id
JOIN artist on artist.artist_id = album2.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id, artist.name
order by number_of_songs desc
limit 10;


select * from track;
-- 8. Return all the track names that have a song length longer than the average song length. Return the name and milliseconds for each track. Order by the song length 
-- with the longest song listed first. 
select name, milliseconds from track where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;
