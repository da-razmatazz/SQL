USE Q1;
Select name, population, area
FROM world
WHERE population>25000000 OR area>3000000;

USE Q2;
Select product_id
FROM products
WHERE low_fats='Y' AND recyclable='Y';

USE Q3;
SELECT employee_id,
	CASE
	WHEN MOD(employee_id,2)=1
	AND
    SUBSTR(name,1,1) != 'M' THEN salary
    ELSE 0
	END AS bonus
FROM employees;

USE Q4;
SELECT min(id), Email
FROM person
GROUP BY Email;
-- done with select statement because Jonathan showed it in the solution.

USE Q5;
SELECT user_id, concat(upper(substr(name,1,1)), lower(substr(name,2,4))) AS fixed_name
FROM users
ORDER BY user_id ASC;
-- returns fixed names.

USE Q6;
SELECT*FROM tree; -- check
SELECT id,
	CASE
    WHEN p_id=2 THEN 'Leaf'
    WHEN p_id is null THEN 'Root'
    WHEN p_id=1 AND id=2 THEN 'Inner'
    Else 'Leaf'
    END AS type
FROM tree;

USE Q7;
CREATE VIEW weather_raw AS
	SELECT
		CASE
		WHEN temperature > LAG(temperature) over() THEN id
		END as id
	FROM weather;
SELECT id FROM weather_raw
WHERE id is not null;

-- another way:

SELECT w1.id
FROM weather as w1, weather as w2
WHERE w1.temperature > w2.temperature AND datediff(w1.recordDate, w2.recordDate) = 1;

USE Q8;
SELECT*FROM activity;

SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id;

USE Q9;
SELECT*FROM rides;

SELECT u.name, SUM(distance) as travelled_distance
FROM users as u
LEFT JOIN rides as r on u.id=r.user_id
GROUP BY u.name
ORDER BY travelled_distance DESC, u.name ASC;


USE Q10;
SELECT * FROM actordirector;

SELECT actor_id, director_id
FROM actordirector
GROUP BY actor_id, director_id
HAVING actor_id=1 AND director_id=1;

USE Q11;

SELECT w.name, SUM(p.width*p.length*p.height*w.units) AS volume
FROM warehouse as w
INNER JOIN products as p on w.product_id=p.product_id
GROUP BY w.name;

USE Q12;
SELECT*FROM queries;


SELECT query_name,
	ROUND(AVG(rating/position),2) as quality,
    ROUND(SUM(rating/100),2) as poor_query_percentage
FROM queries
GROUP BY query_name;


    


