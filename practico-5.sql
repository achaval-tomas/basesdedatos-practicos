DROP TABLE directors;

# 1
CREATE TABLE IF NOT EXISTS directors (
	first_name varchar(50),
    last_name varchar(50),
    total_movies int
);

# 2
INSERT INTO directors (first_name, last_name, total_movies)
SELECT actor.first_name, actor.last_name, total_movies
FROM (
	SELECT film_actor.actor_id, count(film_id) as total_movies
	FROM film_actor
	GROUP BY film_actor.actor_id
	ORDER BY -total_movies
	LIMIT 5
) as top_5 INNER JOIN actor
WHERE actor.actor_id = top_5.actor_id;

SELECT * FROM directors;

# 3
ALTER TABLE customer
ADD premium_customer char
DEFAULT "F";

SELECT * FROM customer LIMIT 5;
 
# 4
UPDATE customer 
JOIN (
	SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id
    ORDER BY -sum(payment.amount) 
    LIMIT 10
) as top
ON customer.customer_id = top.customer_id
SET premium_customer = "T";

SELECT * FROM customer WHERE premium_customer ="T";

# 5
SELECT rating, count(film_id) as film_amount
FROM film GROUP BY rating
ORDER BY -film_amount;

# 6
(SELECT payment_date
FROM payment ORDER BY payment_date DESC LIMIT 1)
UNION
(SELECT payment_date
FROM payment ORDER BY payment_date ASC LIMIT 1);

# 7
SELECT MONTH(payment.payment_date) as month_no, avg(payment.amount) as average_income
FROM payment
GROUP BY month_no;

# 8
SELECT address.district, count(*) as rentals
FROM address LEFT JOIN (
		SELECT customer.customer_id, customer.address_id from
		rental INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    ) as customer_rentals
ON (customer_rentals.address_id = address.address_id)
GROUP BY address.district
ORDER BY rentals DESC
LIMIT 10;

# 9
ALTER TABLE inventory
ADD stock int DEFAULT 5;

SELECT * FROM inventory LIMIT 5;

# 10
DROP TRIGGER IF EXISTS update_stock;

delimiter //
CREATE TRIGGER update_stock AFTER INSERT ON rental
FOR EACH ROW 
BEGIN
	UPDATE inventory 
    SET inventory.stock = inventory.stock - 1
	WHERE NEW.inventory_id = inventory.inventory_id
    AND inventory.stock > 0;
END //
delimiter ; 

# 11
CREATE TABLE IF NOT EXISTS fines (
	rental_id int,
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id),
    amount decimal(20,2)
);

drop table fines;
# 12
drop procedure if exists check_date_and_fine;

delimiter //
create procedure check_date_and_fine()
begin
	insert into fines (rental_id, amount)
    SELECT
		r.rental_id,
        datediff(r.return_date, date_add(r.rental_date, interval 3 day)) * 1.5
	FROM
		rental as r
	where
		datediff(r.return_date,  r.rental_date) > 3;
end;
//
delimiter ;

call check_date_and_fine(); select * from fines;


# 13
create role employee;
grant insert, update, delete ON sakila.rental to employee;

# 14
revoke delete on sakila.rental from employee;
create role administrator;
grant ALL privileges on sakila.* to administrator;

# 15
create role empleado1, empleado2;
grant administrator to empleado1;
grant employee to empleado2;

