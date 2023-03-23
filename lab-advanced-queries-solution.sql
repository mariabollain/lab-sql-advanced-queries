use sakila;

# 2 For each film, list actor that has acted in more films.

CREATE VIEW count_films AS 
SELECT actor_id, COUNT(film_id) as num_films 
FROM film_actor
GROUP BY actor_id;

WITH rank_films AS (SELECT FA.actor_id, FA.film_id, CF.num_films, RANK() OVER (
PARTITION BY FA.film_id ORDER BY CF.num_films ASC) AS ranking
FROM film_actor FA
JOIN count_films CF ON FA.actor_id = CF.actor_id)
SELECT film_id, actor_id 
FROM rank_films
WHERE ranking = 1;

# 1 List each pair of actors that have worked together.

SELECT A.actor_id, B.actor_id
FROM film_actor A
JOIN film_actor B 
ON A.film_id = B.film_id AND A.actor_id < B.actor_id;

