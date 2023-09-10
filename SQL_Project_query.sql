/*Query 1 - query used for first insight*/
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
ORDER BY 2, 1;


/*Query 2 - query used for second insight*/
SELECT DATE_PART('month', r.rental_date) rental_month,
        DATE_PART('year', r.rental_date) rental_year,
        s.store_id store_id,
        COUNT(*)
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC;


SELECT DATE_TRUNC('month', p.payment_date) pay_mon,
        t1.fullname,
        COUNT(*),
        SUM(p.amount) pay_amount
FROM (SELECT p.customer_id customer_id,
        CONCAT(c.first_name, ' ', c.last_name) fullname,
        SUM(p.amount) pay_amount      
        FROM payment p
        JOIN customer c
        ON p.customer_id = c.customer_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
        LIMIT 10) t1
JOIN payment p
ON t1.customer_id = p.customer_id
GROUP BY 1, 2
ORDER BY 2;