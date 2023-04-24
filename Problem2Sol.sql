USE airbnb;

-- Question 1

SELECT * FROM rooms;
SELECT AVG(price) FROM rooms;

SELECT MAX(number_of_reviews)
FROM rooms;

SELECT MIN(reviews_per_month)
FROM rooms;

SELECT COUNT(reviews_per_month)
FROM rooms
Where reviews_per_month is not null; -- counts the not null values in the column.

Select DISTINCT neighbourhood_group
FROM rooms; -- returns distinct values from column.

SELECT COUNT(DISTINCT neighbourhood_group)
FROM rooms; -- returns num of unique values from column.

-- Question 2

SELECT neighbourhood_group AS hood, AVG(price) AS Average_price
FROM rooms
GROUP BY neighbourhood_group
ORDER BY Average_price DESC;
-- GROUP BY returns the neighbourhood_group column with the uniqe neighbourhoods.
-- The rest returns the average price for apt per neigbourhood, in a descending order.


Select price_range, COUNT(id) AS num_of_rooms
FROM rooms
GROUP BY price_range;
-- returns number of rooms for each price range.

SELECT MAX(reviews_per_month) AS max_reviews, room_type
FROM rooms
GROUP BY room_type;
-- returns max number of reviews for each room type.

SELECT AVG(price) AS average_price_for_reviews,
number_of_reviews_range
FROM rooms
GROUP BY number_of_reviews_range
ORDER BY number_of_reviews_range ASC;
-- returns avg price per num of reviews range and orders ascending.

SELECT COUNT(id) AS num_of_rooms, neighbourhood
FROM rooms
GROUP BY neighbourhood
ORDER BY num_of_rooms DESC;
-- returns num of rooms in each neigbourhood in an descending order.

SELECT COUNT(id) AS num_of_rooms, neighbourhood, neighbourhood_group
FROM rooms
WHERE neighbourhood_group IN ('Manhattan','Queens')
GROUP BY neighbourhood_group, neighbourhood
ORDER BY neighbourhood_group ASC;
-- returns the num of rooms in each neighbourhood and nighbourhood group in an ascending order.
-- After that, filters only resluts from Manhattan and Queens.

SELECT AVG(number_of_reviews) AS reviews_per_hood, neighbourhood
FROM rooms
Where neighbourhood_group = 'Brooklyn'
GROUP BY neighbourhood
ORDER BY reviews_per_hood DESC;
-- returns average of num of reviews per neighbourhood in Brooklyn.

-- Question 3
SELECT COUNT(id) AS num_of_rooms, host_id
FROM rooms
GROUP BY host_id
HAVING COUNT(id) > 100;
-- returns only the hosts with more than 100 rooms.

SELECT AVG(price) AS hood_avg_price, neighbourhood
FROM rooms
GROUP BY neighbourhood
HAVING hood_avg_price > 150;
-- returns a list of neighbourhoods with an average price higher than 150.

SELECT AVG(price) AS hood_avg_price, neighbourhood, neighbourhood_group
FROM rooms
GROUP BY neighbourhood, neighbourhood_group
HAVING hood_avg_price > 150 AND neighbourhood_group = 'Bronx';
-- returns a list of neighbourhoods with an average price higher than 150, only in the Bronx.

SELECT AVG(number_of_reviews), neighbourhood_group, room_type
FROM rooms
GROUP BY neighbourhood_group, room_type
ORDER BY neighbourhood_group ASC;
-- returns avg number of reviews for each room type in each neighbourhood group.

SELECT AVG(number_of_reviews) AS reviews_avg_num, neighbourhood_group, room_type
FROM rooms
GROUP BY neighbourhood_group, room_type
HAVING reviews_avg_num >20
ORDER BY neighbourhood_group ASC;
-- returns avg number of reviews for each room type in each neighbourhood group.
-- restricts the query to avg greater than 20.

SELECT AVG(number_of_reviews) AS reviews_avg_num, neighbourhood_group, room_type
FROM rooms
GROUP BY neighbourhood_group, room_type
HAVING reviews_avg_num >20 AND room_type = 'Private Room'
ORDER BY neighbourhood_group ASC;
-- returns avg number of reviews for each room type in each neighbourhood group.
-- restricts the query to avg greater than 20.
-- further restricts query to show only Private room type.

-- Question 4
USE spotify;

SELECT COUNT(track_id) AS num_of_tracks, artist
FROM tracks
GROUP BY artist
ORDER BY num_of_tracks DESC;
-- returns num of tracks for each artist in a descending order.

SELECT AVG(duration) AS avg_duration, genre
FROM tracks
GROUP BY genre
ORDER BY avg_duration DESC;
-- returns avg track duration per genre.

SELECT MIN(danceability) AS min_daceability,
	MAX(danceability) AS max_danceability, 
	AVG(danceability) AS avg_danceability,
    artist
FROM tracks
GROUP BY artist
HAVING artist = 'Queen' OR artist ='The Beatles';
-- returns min, max & avg danceability for tracks by Queen and The Beatles.

SELECT COUNT(genre) AS pop_genres
FROM tracks
WHERE genre LIKE '%pop%';
-- returns all genres that contain 'pop' in their name.

SELECT COUNT(track_id) AS num_of_tracks,
	MAX(popularity) AS max_popularity,
	MIN(popularity) AS min_popularity, 
	artist, genre
FROM tracks
GROUP BY artist, genre
HAVING genre LIKE '%rock%'
ORDER BY num_of_tracks DESC;
-- returns num of tracks, min and max popularity per artist in each rock genre.

SELECT COUNT(track_id) num_of_tracks, genre, release_year
FROM tracks
GROUP BY genre, release_year
HAVING num_of_tracks > 10; -- release_year BETWEEN 2005 AND 2010 AND
-- first query returns num of tracks per genre released between 2005 and 2010.
-- after sevond AND, restricts the num of tracks to above 10,
-- however, there aren't any. it may be that droping the release year restriction will give results.

SELECT COUNT(track_id) AS num_of_tracks, artist, release_year
FROM tracks
GROUP BY release_year, artist
HAVING artist = 'Coldplay'
ORDER BY release_year ASC;
-- returns num of tracks released by Coldplay each year.

-- Question 5
USE bookreview;

-- first_name, last_name, email, birthdate, and gender
SELECT user_id, first_name, last_name, email, birthdate, g.gender
FROM users AS u
INNER JOIN genders AS g ON u.gender_id=g.gender;
-- returns the above columns from users table with the matching gender_id from genders table.

SELECT user_id, first_name, last_name, email, birthdate, g.gender
FROM users AS u
INNER JOIN genders AS g ON u.gender_id=g.gender
WHERE YEAR(birthdate)=2002;
-- "" "" and restricts to the birthyear 2002.

SELECT COUNT(user_id) AS num_of_users, YEAR(birthdate) AS birthyear
FROM users
GROUP BY YEAR(birthdate)
ORDER BY YEAR(birthdate) ASC;
-- returns num of users per birthyear in an ascending order.

SELECT COUNT(user_id) AS num_of_users, YEAR(birthdate) AS birthyear
FROM users
GROUP BY birthyear
HAVING num_of_users >54
ORDER BY birthyear ASC;
-- returns num of users per birthyear, but only where there are 54 users and above.

-- first_name, last_name, email, birthdate, country and city for all users
SELECT first_name, last_name, email, birthdate, country, city
FROM users AS u
INNER JOIN locations AS l ON u.location_id=l.location_id;
-- returns first & last name, email, birthdate and location of users.

-- Restrict your query to display only users living in the UK
SELECT first_name, last_name, email, birthdate, country, city
FROM users AS u
INNER JOIN locations AS l ON u.location_id=l.location_id
WHERE l.country = 'United Kingdom';
-- returns first & last name, email, birthdate and location, but only for UK users.

-- Write a query to break down the number of users living in each country and city. 
-- Sort the output by the number of users (descending).
SELECT COUNT(user_id) AS num_of_users, l.country, l.city
FROM users AS u
INNER JOIN locations AS l ON u.location_id=l.location_id
GROUP BY l.country, l.city
ORDER BY num_of_users DESC;
-- returns num of users per country and city in a descending order.

-- Restrict your query to count only users above the age 30
SELECT COUNT(user_id) AS num_of_users, l.country, l.city, u.birthdate
FROM users AS u
INNER JOIN locations AS l ON u.location_id=l.location_id
GROUP BY l.country, l.city, u.birthdate
HAVING YEAR(u.birthdate) = 1992
ORDER BY num_of_users DESC;
-- ^ "" "" but for users above 30 years old.

-- Write a query to display the first_name, last_name, email, age, 
-- and occupation_name for all users
Select first_name, last_name, email, SUM(2023-YEAR(birthdate)) AS age,
o.occupation_name
FROM users AS u
INNER JOIN occupations AS o ON u.occupation_id=o.occupation_id
GROUP BY first_name, last_name, email ,o.occupation_name;
-- returns first & last name, ermail, age and occupation.

-- Write a query to display the average age for each occupation
Select AVG(2023-YEAR(birthdate)) AS age, o.occupation_name
FROM users AS u
INNER JOIN occupations AS o ON u.occupation_id=o.occupation_id
GROUP BY o.occupation_name;
-- returns the avg age per occupation.

-- Restrict your query to display only occupations with average age greater than 40
Select AVG(2023-YEAR(birthdate)) AS age, o.occupation_name
FROM users AS u
INNER JOIN occupations AS o ON u.occupation_id=o.occupation_id
GROUP BY o.occupation_name
HAVING age > 40;
-- returns the avg age per occupation, but only if age is above 40.

-- Write a query to display the average num_pages for each author.
-- Sort the output by the average number of pages (descending)ץ
SELECT AVG(num_pages) AS avg_pages, a.authors
FROM books as b
INNER JOIN authors AS a ON b.author_id=a.author_id
GROUP BY a.authors
ORDER BY avg_pages DESC;
-- returns avg pages of books per author in a descending order.

-- Write a query to display the number of books for each language.
-- Sort the output by the number of books (descending).
SELECT COUNT(book_id) AS num_of_books, l.language_name
FROM books AS b
INNER JOIN languages AS l ON b.language_code=l.language_code
GROUP BY l.language_name
ORDER BY num_of_books DESC;
-- returns num of books per language.

-- Write a query to display the number of unique publishers by each language.
-- Sort the output by the number of unique publishers (descending).
Select COUNT(DISTINCT b.publisher_id) AS num_of_publishers,
	l.language_name
FROM books AS b
INNER JOIN publishers AS p ON b.publisher_id=p.publisher_id
INNER JOIN languages AS l ON b.language_code-l.language_code
GROUP BY l.language_name
ORDER BY num_of_publishers DESC;
-- returns num of distinct publishers per language.

-- Question 6
USE bookreview;
-- Write a query to display the first_name, last_name, email,
-- birthdate, occupation_name, country and city for all users
SELECT first_name, last_name, email,birthdate, 
	o.occupation_name AS occupation, l.country AS country, l.city AS city
FROM users as u
INNER JOIN occupations AS o ON u.occupation_id=o.occupation_id
INNER JOIN locations AS l ON u.location_id=l.location_id
GROUP BY first_name, last_name, email,birthdate, 
	occupation, country, city;
-- returns first & last name, email, birthdate, occupation, counry and city for all users.

-- Write a query to breakdown the number of users for each country and occupation
SELECT COUNT(user_id) AS num_users, o.occupation_name AS occupation,
	l.country AS country
FROM users AS u
INNER JOIN occupations AS o ON u.occupation_id=o.occupation_id
INNER JOIN locations AS l ON u.location_id=l.location_id
GROUP BY occupation, country;
-- returns num of users in every occupation and country.

-- Write a query to display the rating_id, rating_date, 
-- rating, book title, and user's full name for each rating.
SELECT rating_id, rating_date, rating, b.title AS book_title, 
	concat(u.first_name,' ',u.last_name) AS full_name
FROM ratings AS r
INNER JOIN books AS b ON r.book_id=b.book_id
INNER JOIN users AS u ON r.user_id=u.user_id
GROUP BY rating_id, rating_date, rating, book_title, full_name;
-- returns rating data, book title and full names of users.

-- Restrict your query to display ratings related to the 'Harry Potter' book-series
CREATE VIEW HP_readers AS
SELECT rating_id, rating_date, rating, b.title AS book_title, 
	concat(u.first_name,' ',u.last_name) AS full_name
FROM ratings AS r
INNER JOIN books AS b ON r.book_id=b.book_id
INNER JOIN users AS u ON r.user_id=u.user_id
GROUP BY rating_id, rating_date, rating, book_title, full_name
HAVING book_title LIKE'%(Harry Potter %';
-- returns rating data, book title and full names of users, but only for the Harry Potter book series.

-- How many unique users have rated titles related to the 'Harry Potter' book-series?
SELECT COUNT(DISTINCT full_name) AS HP_readers
FROM(
	SELECT rating_id, rating_date, rating, b.title AS book_title, 
	concat(u.first_name,' ',u.last_name) AS full_name
	FROM ratings AS r
	INNER JOIN books AS b ON r.book_id=b.book_id
	INNER JOIN users AS u ON r.user_id=u.user_id
	GROUP BY rating_id, rating_date, rating, book_title, full_name
	HAVING book_title LIKE'%(Harry Potter %'
) AS unique_HP_readers;
-- returns the num of unique readers of Harry Potter related books.

-- same query but using the CREATE VIEW function.
SELECT COUNT(DISTINCT full_name) AS HP_readers
FROM(
	SELECT*FROM HP_readers
) AS unique_HP_readers;
-- returns the num of unique readers of Harry Potter related books.

-- How many unique users have rated titles related to the 'Harry Potter' book-series.
-- Break down your result by each country
CREATE VIEW HP_readers_country AS
SELECT DISTINCT u.user_id AS user_id, u.location_id, b.title AS title
FROM ratings AS r
INNER JOIN users AS u ON r.user_id=u.user_id
INNER JOIN books AS b ON r.book_id=b.book_id
GROUP BY title, user_id
HAVING title LIKE'%(Harry Potter %';
-- returns a view for the source table for next query.

-- using the created view ^
SELECT l.country, COUNT(HP.user_id) AS num_users, HP.title
FROM(
	SELECT*FROM HP_readers_country
) AS HP
INNER JOIN locations AS l ON HP.location_id=l.location_id
GROUP BY country, title;
-- returns num of users who rated Harry Potter related books by country.

-- Question 7

-- Write a query to display the book title, num_pages and publisher name for all books,
-- including those with no publisher details
SELECT title, num_pages, publisher_name
FROM books AS b
LEFT JOIN publishers AS p ON b.publisher_id=p.publisher_id
GROUP BY  title, num_pages, publisher_name;
-- returns book titles, num of pages and publsihers names for all books, regardless of them having publishers details.

-- Restrict your query to display only books with no publisher details
SELECT title, num_pages, publisher_name
FROM books AS b
LEFT JOIN publishers AS p ON b.publisher_id=p.publisher_id
GROUP BY  title, num_pages, publisher_name
HAVING publisher_name IS NOT NULL;
-- restricts to books which have publishers names.
-- same result can be acheived by using INNER JOIN and dropping HAVING condition instead of LEFT.

-- Write a query to display the book title, num_pages, publication_date,
-- and authors for all books, including those with no author details
SELECT  title, num_pages, publication_date, authors
FROM books AS b
LEFT JOIN authors AS a ON b.author_id=a.author_id
GROUP BY title, num_pages, publication_date, authors;
-- returns books titles, num pages, pub date and authors, even if no authors listed.

-- Restrict your query to display only books with no author details
SELECT  title, num_pages, publication_date, authors
FROM books AS b
LEFT JOIN authors AS a ON b.author_id=a.author_id
GROUP BY title, num_pages, publication_date, authors
HAVING authors IS NULL;
-- returns only books without authors listed.

-- How many books have never been rated?
SELECT rating_id, COUNT(b.book_id) AS unrated
FROM books AS b
LEFT JOIN ratings AS r ON r.book_id=b.book_id
GROUP BY b.book_id, rating_id
HAVING rating_id IS NULL;
-- 1857 books.

-- Question 8
USE carsonline;

SELECT car_id, price, car_make, car_model, car_year
FROM cars AS c
INNER JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY car_id, price, car_make, car_model, car_year;
-- returns car_id, price, car_make, car_model, car_year.

-- restrict your query to display only cars made by bmw on 2019
SELECT car_id, price, car_make, car_model, car_year
FROM cars AS c
INNER JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY car_id, price, car_make, car_model, car_year
HAVING car_make='bmw' AND car_year=2019;
-- returns only cars manufactured by BMW in 2019.

-- Display the average price for each car model during this year.
SELECT car_make, car_model, AVG(price), car_year
FROM cars AS c
INNER JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY  car_make, car_model, car_year
HAVING car_year=2019 AND car_make='bmw'
ORDER BY car_make ASC;
-- returns avg price of BMW 2019 models.

-- Write a query to display the car_id, price and fuel_type_name for each car
SELECT  car_id, price, fuel_type_name
FROM cars AS c
INNER JOIN fuel_types AS ft ON c.fuel_type_id=ft.fuel_type_id
GROUP BY  car_id, price, fuel_type_name;

-- Display the number of cars by each fuel_type_name.
-- Sort the output by the number of cars (descending)
SELECT COUNT(car_id) AS num_cars, fuel_type_name
FROM cars AS c
INNER JOIN fuel_types AS ft ON c.fuel_type_id=ft.fuel_type_id
GROUP BY fuel_type_name;
-- returns num of cars per fuel type.

-- Write a query to display the car_id, price and transmission_name for each car
SELECT car_id, price, t.transmission_type_id
FROM cars AS c
INNER JOIN transmission_types AS t ON c.transmission_type_id=t.transmission_type_id
GROUP BY car_id, price, transmission_type_id;
-- returns car_id, price and transmission_type_id for all cars.

-- Display the average price for each transmission_name.
-- Sort the output by the average price (descending)
SELECT AVG(price) AS avg_price, transmission_name
FROM cars AS c
INNER JOIN transmission_types AS t ON c.transmission_type_id=t.transmission_type_id
GROUP BY transmission_name
ORDER BY avg_price DESC;
-- returns avg price per transmission type.

-- Write a query to display the unique number of hybrid cars for each car_make.
-- Sort the output by the number of cars (Descending)
SELECT COUNT(DISTINCT car_id) AS num_cars, fuel_type_name, ct.car_make
FROM cars AS c
INNER JOIN fuel_types AS ft ON c.fuel_type_id=ft.fuel_type_id
INNER JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY fuel_type_name, car_make
HAVING fuel_type_name='Hybrid'
ORDER BY num_cars DESC;
-- returns num of Hybrid cars per manufacturer.

-- Write a query to display the number of manual-gearbox cars, by each car_year and car_make.
-- Sort the output by the year (ascending).
SELECT COUNT(transmission_name) AS num_cars,
transmission_name, car_year, car_make
FROM cars AS c
INNER JOIN transmission_types AS t ON c.transmission_type_id=t.transmission_type_id
INNER JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY transmission_name, car_year, car_make
HAVING transmission_name='Manual'
ORDER BY car_year ASC;
-- returns num of cars with manual gearbox by year and manufacturer.

-- Write a query to display the customer_id,
-- first_name, last_name, birth_date, and gender
SELECT customer_id, first_name, last_name, birth_date, gender
FROM customers AS c
INNER JOIN genders AS g ON c.gender_code=g.gender_code
GROUP BY customer_id, first_name, last_name, birth_date, gender;
-- returns customer_id, first_name, last_name, birth_date, and gender.

-- Display the number of customers by each gender
SELECT COUNT(customer_id), gender
FROM customers AS C
INNER JOIN genders AS g ON c.gender_code=g.gender_code
GROUP BY gender;
-- returns number of customers per gender.

-- Display the number of customers by each gender and age.
-- Sort the output by the number of customers (descending)
SELECT COUNT(customer_id) AS num_customers, gender, 2023-YEAR(birth_date) AS age
FROM customers AS c
INNER JOIN genders AS g ON c.gender_code=g.gender_code
GROUP BY gender, age
ORDER BY num_customers DESC;
-- returns num of customers by gender and age.

-- Restrict your query to for customers above the age 59
SELECT COUNT(customer_id) AS num_customers, gender, 2023-YEAR(birth_date) AS age
FROM customers AS c
INNER JOIN genders AS g ON c.gender_code=g.gender_code
GROUP BY gender, age
HAVING age>59
ORDER BY num_customers DESC;
-- returns num of customers by gender and above the age of 59.

-- Write a query to display the number of customers living in Australia.
SELECT COUNT(customer_id) AS num_customers, country
FROM customers AS c
INNER JOIN locations AS l ON c.location_code=l.location_code
GROUP BY country
HAVING country='Australia';
-- returns num of customers from Australia.

-- Write another query to display the number of customers with
-- updated phone_number living in Australia (customers who has value in phone_number)
SELECT COUNT(customer_id) AS customer, phone_number, country
FROM customers AS c
INNER JOIN locations AS l ON c.location_code=l.location_code
GROUP BY phone_number, country
HAVING country='Australia' AND phone_number IS NOT NULL;
-- returns 240 customers with phone numbers that live in Australia.

-- Write another query to display the number of australian customers
-- with NULL value in their phone_number, break down the result for each city,
-- sort it by the count (descending).
SELECT COUNT(customer_id) AS customer, phone_number, country, city
FROM customers AS c
INNER JOIN locations AS l ON c.location_code=l.location_code
GROUP BY phone_number, country, city
HAVING country='Australia' AND phone_number IS NULL
ORDER BY customer DESC;
-- returns num of customers with null value in their phone number, by city in Australia.

-- Write a query to display the customer_id and
-- full name of customers who bought more than 5 cars
SELECT s.customer_id, concat(first_name, ' ', last_name) AS full_name,
COUNT(car.car_id) AS num_cars
FROM sales AS s
INNER JOIN customers AS c ON s.customer_id=c.customer_id
INNER JOIN cars AS car ON s.car_id=car.car_id
GROUP BY customer_id, full_name
HAVING num_cars > 5;
-- returns customer id and full name for customers who bought more than 6 cars.

-- Not every car on the cars table has been sold. 
-- Write a query to display the percent of sold cars.
CREATE VIEW allcars AS
SELECT customer_id, c.car_id
FROM cars AS c
LEFT JOIN sales AS s ON c.car_id=s.car_id
GROUP BY customer_id, car_id;

SELECT (COUNT(*) / (SELECT COUNT(*) FROM allcars)) * 100 AS 'Percentage'
FROM allcars
WHERE customer_id IS NOT NULL;
-- returns the percentage of sold cars on the basis that every sold car has a customer id.

-- On 2019 (of purchase date), What was the average price of sold cars made by Audi?
CREATE VIEW audicars AS
SELECT c.car_id, s.customer_id, c.price, ct.car_make, 
YEAR(s.purchase_date) AS purchase_year
FROM cars AS c
LEFT JOIN sales AS s ON c.car_id=s.car_id
LEFT JOIN car_types AS ct ON c.car_type_id=ct.car_type_id
GROUP BY car_id, s.customer_id, c.price, ct.car_make, purchase_year
HAVING ct.car_make= 'audi' AND purchase_year=2019;

SELECT AVG(price)
FROM audicars;
-- avg price fir Audi cars in 2019 was 22620.2855.

-- Question 9
USE students_survey;
-- Write a query to display the student_id, full_name and university_id
-- for all students who go to the same university as student_id 6043.
SELECT student_id, full_name, university_id
FROM survey
WHERE university_id= (
		SELECT university_id
        FROM survey
        WHERE student_id=6043
);
-- returns all students who go to the same university as student 6043.

-- Write a query to display the survey_id and survey_date 
-- for all surveys that were taken on the same date as survey_id 532
SELECT survey_id, survey_date 
FROM survey
WHERE survey_date=(
		SELECT survey_date
        FROM survey
        WHERE survey_id=532
);
-- returns all survey dates as id 532's.

-- Write a query to display the student_id, full_name and
-- height for all students who are taller than Josephina Athow (full_name)
SELECT student_id, full_name, height_cm
FROM survey
WHERE height_cm > (
		SELECT height_cm
		FROM survey
        WHERE full_name = 'Josephina Athow'
);
-- returns all students who are taller than Josephina Athow.

-- Write a query to display the student_id, full_name and age
-- for all students younger than the student who filled survey number 10
SELECT student_id, full_name, age
FROM survey
WHERE age < (
		SELECT age
        FROM survey
        WHERE survey_id=10
);
-- returns all students who are younger than the one who filled survey no. 10.

-- Write a query to display the student_id, full_name, and father_job,
-- for all students whose father works in the same job 
-- as (the father of) Christina Rediers (full_name)
SELECT student_id, full_name, father_job
FROM survey
WHERE father_job=(
		SELECT father_job
        FROM survey
        WHERE full_name='Christina Rediers'
);
-- returns all students whose father job the same as Christina Rediers' father.

-- Write a query to display the student_id, full_name, father_job,
-- and mother_job for all students whose: 
-- a. Father works in the same job as (the father of) Christina Rediers
-- b. Mother works in the same job as (the mother of) Christina Rediers
SELECT student_id, full_name, father_job, mother_job
FROM survey
WHERE father_job=(
		SELECT father_job
        FROM survey
        WHERE full_name='Christina Rediers'
) AND mother_job= (
		SELECT mother_job
        FROM survey
        WHERE full_name='Christina Rediers'
);
-- returns all students whose parents work in the same job as Christina Rediers' parents.

-- Write a query to display the student_id, full_name and age 
-- for all students older than the average
SELECT student_id, full_name, age
FROM survey
WHERE age > (
		SELECT AVG(age)
        FROM survey
);
-- returns all students older than the avg age.

-- Write a query to display the student_id, full_name, age and height 
-- for all students older than the average, and taller than the average
SELECT student_id, full_name, age, height_cm
FROM survey
WHERE age > (
		SELECT AVG(age)
        FROM survey
) AND height_cm > (
		SELECT AVG(height_cm)
        FROM survey
);
-- returns all students older than the avg and taller than the avg.