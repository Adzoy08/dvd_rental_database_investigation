SELECT film_title, category_name, COUNT(*) rental_count
FROM (SELECT f.film_id film_id,
        i.inventory_id inventory_id,
        r.rental_id rental_id,
        f.title film_title,
        c.name category_name
        FROM film f
        JOIN film_category fc
        ON f.film_id = fc.film_id
        JOIN category c
        ON fc.category_id = c.category_id
        JOIN inventory i
        ON f.film_id = i.film_id
        JOIN rental r
        ON i.inventory_id = r.inventory_id
        WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1
GROUP BY 1, 2
ORDER BY 2, 1