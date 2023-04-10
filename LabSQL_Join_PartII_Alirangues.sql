-- Lab | SQL Queries - Lesson 2.8
-- Week 2 -Day 4 -- Afternoon

USE sakila;

-- Write a query to display for each store its store ID, city, and country.
SELECT * FROM store;
SELECT * FROM address;

SELECT s.store_id, c.city, co.country 
FROM store AS s
JOIN address as a
ON s.address_id = a.address_id
JOIN city as c
ON a.city_id = c.city_id
JOIN country as co
ON c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT sto.store_id, sum(p.amount) AS total_earned
FROM store as sto
JOIN staff as sta
ON sto.store_id = sta.store_id
JOIN payment as p
ON sta.staff_id = p.staff_id
group by sto.store_id;

-- Which film categories are longest?
SELECT c.name, max(f.length) as max_length
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
order by max_length DESC;

-- Display the most frequently rented movies in descending order.
SELECT * FROM film
ORDER BY rental_rate DESC;

-- List the top five genres in gross revenue in descending order.
SELECT * FROM category; -- name
SELECT * FROM payment; -- amount

SELECT c.name, sum(p.amount) AS revenue
FROM category AS c
join film_category as fc
ON c.category_id = fc.category_id
JOIN inventory as i
ON fc.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM film; -- Academy dinosaur
SELECT * FROM rental; -- amount
SELECT * FROM inventory; -- store ID

SELECT f.title, i.store_id
FROM film AS f
JOIN inventory as i
ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" AND i.store_id=1;

-- Get all pairs of actors that worked together.
SELECT * FROM film_actor; -- actors with same film_id

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS Actor1, CONCAT(a2.first_name, ' ', a2.last_name) AS Actor2 
FROM actor AS a
JOIN film_actor AS fa1 
ON a.actor_id = fa1.actor_id
JOIN film_actor AS fa2 
ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
JOIN actor AS a2 ON a2.actor_id = fa2.actor_id
ORDER BY Actor1, Actor2;

/*
Bonus:
These questions are tricky, you can wait until after Monday's lesson to use new techniques to answer them!
*/
-- Get all pairs of customers that have rented the same film more than 3 times.
-- Similar to previous question but different aggregation method

-- For each film, list actor that has acted in more films.
