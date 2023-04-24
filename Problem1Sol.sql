#Question 1

USE playcenter;
SELECT * FROM players; #Returns entire 'players' table

SELECT first_name, last_name, city
FROM players; #returns these 3 columns from players

SELECT email_address, country, street_address
FROM players; #returns these 3 columns from players

SELECT player_id, total_playing_minutes, installed_games
FROM players; #returns these 3 columns

SELECT player_id, age_group, total_playing_minutes
FROM players;#returns these 3 columns

#Question 2

SELECT player_id, amount_spent_usd, concat(amount_spent_usd*0.8) AS amount_spent_euro
FROM players;

SELECT player_id, last_name, first_name, amount_spent_usd, Installed_games, concat(amount_spent_usd/installed_games) AS amount_spent_per_game
FROM players;

SELECT player_id, concat(first_name," ",last_name) AS full_name
FROM players;

SELECT player_id, email_address, concat(country, ", ", city,", ", street_address) AS full_address,
concat(total_playing_minutes/60) AS total_playing_hours
FROM players; -- returns player ID, e-mail Address, full address (concateted) and total playing hours.ALTER

SELECT concat(first_name, " ",last_name," ", "preferred language is ", preferred_language) AS player_language
FROM players;

SELECT DISTINCT preferred_language
FROM players; -- returns the distinct languages

SELECT DISTINCT gender
FROM players; -- returns the distinct genders

Select DISTINCT age_group
FROM players; -- returns the distinct age groups

SELECT DISTINCT concat(gender," ", age_group) AS age_group_by_gender
FROM players; -- returns the distinct age_groups by gender

USE onlinecampus;

SELECT * FROM courses;

Select course_id, price_usd, num_students, content_duration_minutes
From courses;

Select course_title, num_students, 
concat(positive_reviews+negative_reviews) AS total_reviews,
concat(positive_reviews+negative_reviews/num_students) AS reviews_students_ratio
From courses;

SELECT course_id, course_title, num_lessons, content_duration_minutes,
concat(content_duration_minutes/num_lessons)AS average_lecture_duration
FROM courses;

Select course_id,course_title,num_students,price_usd,
concat(num_students*price_usd)AS total_course_revenues
FROM courses;

Select course_id,concat_ws(" - ", course_subject,course_title)
From courses;

Select course_id,price_usd,content_duration_minutes,
concat(content_duration_minutes/60)AS content_duration_hours
FROM courses;

Select DISTINCT course_subject
From courses;

Select DISTINCT course_level
From courses;

Select DISTINCT concat_ws(" - ", course_subject,course_level)
From courses;

USE umart;

Select row_id, discount, unit_price,customer_id
FROM orders
Where customer_id=3;

Select order_id, shipping_cost, customer_name
From orders
WHERE customer_name='Skyler Youster';

Select customer_segment, customer_id, customer_name
FROM orders
WHERE customer_segment='Corporate';

Select order_priority, discount, customer_name, customer_region
FROM orders
Where customer_region IN ('Central', 'West');

Select DISTINCT customer_segment
From orders;
Select order_id, ship_mode, customer_segment, product_id
From orders
Where customer_segment IN ('Consumer','Home Office');

Select order_id, ship_mode, customer_segment, unit_price
From orders
WHERE unit_price BETWEEN 10 And 20;

Select order_id, discount, unit_price, amount_of_products, profit, discount
From orders
WHERE profit BETWEEN 100 AND 200;

-- Question 8
SELECT customer_id, customer_name
FROM orders
WHERE customer_name LIKE 'E%'; -- returns all customer names that start with an 'E'.

SELECT customer_id, customer_name
FROM orders
WHERE customer_name LIKE '%e'; -- returns all customer names that end with an 'e'.

SELECT customer_id, customer_name
FROM orders
WHERE customer_name LIKE '%e%'; -- returns all customer names that has an 'e' somewhere.

SELECT customer_id, customer_name
FROM orders
WHERE customer_name LIKE 'E%' OR customer_name LIKE 'A%';
-- returns all customer names that start with 'E' or 'A'.

SELECT customer_id, customer_name
FROM orders
WHERE customer_name LIKE '%e' OR customer_name LIKE '%i';
-- returns all customer names that end with 'e' or 'i'.

Select customer_id, customer_country, customer_region
FROM orders
WHERE customer_region is NULL; -- returns all customer without region.ALTER

Select order_priority, discount, shipping_cost, ship_mode, discount
FROM orders
WHERE order_priority = 'High' AND ship_mode = 'Regular Air';
-- returns all records with High order priority and Regular Air ship mode.ALTER

Select order_id, customer_id, customer_region, customer_country, customer_segment
FROM orders
WHERE (customer_segment = 'Small Business' OR customer_segment = 'Corporate') 
AND customer_region NOT IN ('North','South');
-- returns records where customer segment is Small Business or Corporate and where customer region is not North or South.

SELECT order_id, discount, unit_price, profit, discount
FROM orders
WHERE (profit BETWEEN 100 AND 200) AND (discount < 0.1 And discount > 0.5);

SELECT order_id, discount, unit_price, profit
FROM orders
WHERE profit > 100
ORDER BY discount DESC;

SELECT order_id, discount, unit_price, profit
FROM orders
WHERE profit > 100
ORDER BY discount DESC, profit;

SELECT row_id, order_priority, unit_price, shipping_cost, customer_name
FROM orders
ORDER BY shipping_cost LIMIT 5;

SELECT row_id, order_priority, unit_price, shipping_cost, profit
FROM orders
ORDER BY profit LIMIT 3;