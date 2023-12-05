-- HOMEWORK W5D4

--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating



CREATE OR REPLACE PROCEDURE add_film (
	title varchar, 
	description varchar, 
	release_year integer, 
	language_id integer, 
	rental_duration integer, 
	rental_rate NUMERIC(4,2), 
	len integer, 
	replacement_cost NUMERIC (5,2), 
	rating mpaa_rating)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, "length", replacement_cost, rating)
	VALUES (title, description, release_year, language_id, rental_duration, rental_rate, len, replacement_cost, rating);
END
$$;

CALL add_film('STARGATE', 'When a mysterious woman makes Professor Daniel Jackson an offer he cannot refuse he ends up in a secret Air Force military base.  His mission: to decode an ancient Egyptian artifact known as the StarGate', 1995, 1, 2, 2.99, 119, 15.00, 'PG-13');

DROP PROCEDURE IF EXISTS add_film;

SELECT *
FROM film f 
ORDER BY film_id DESC;






--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category







SELECT * FROM category;

CREATE or REPLACE FUNCTION num_films(id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
	 	DECLARE film_count integer;
BEGIN
		SELECT count(*) AS films_in_cat INTO film_count
		FROM film_category f
		JOIN category c
		ON c.category_id = f.category_id 
		GROUP BY f.category_id, c.name ORDER BY count(*) DESC;
		RETURN film_count;
END
$$;

SELECT  num_films(15);

DROP FUNCTION IF exists num_films(integer)
	





