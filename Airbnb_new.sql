## What is the average cost of Airbnb by city in LA for 2 people and 4 people? 
## What is their average review scores? 

# Check the data types of each column within the AirbnbNew csv file
SHOW FIELDS FROM Airbnb.airbnbnew;

## Los Angeles, CA 
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Los Angeles%';

# Find the average price of Airbnb for 2 people
# First, need to remove the dollar sign from the price field and convert from TEXT to INT
UPDATE Airbnb.airbnbnew
SET price = replace(price, '$', '');

SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 2 AND 3 AND host_location LIKE '%Los Angeles%';

# Find the average price of Airbnb for 4 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 4 and 5 AND host_location LIKE '%Los Angeles%';

# Find the average review score rating
SELECT COUNT(number_of_reviews) AS Num_of_Reviews, AVG(review_scores_rating) AS Avg_Review_Rating
FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Los Angeles%'; 


## Santa Monica, CA 
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Santa Monica%';

# Find the average price of Airbnb for 2 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 2 AND 3 AND host_location LIKE '%Santa Monica%';

# Find the average price of Airbnb for 4 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 4 AND 5 AND host_location LIKE '%Santa Monica%';

# Find the average review score rating
SELECT COUNT(number_of_reviews) AS Num_of_Reviews, AVG(review_scores_rating) AS Avg_Review_Rating
FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Santa Monica%'; 


## Long Beach, CA
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Long Beach%';

# Find the average price of Airbnb for 2 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 2 AND 3 AND host_location LIKE '%Long Beach%';

# Find the average price of Airbnb for 4 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 4 AND 5 AND host_location LIKE '%Long Beach%';
# Null value, therefore need to find the average price of Airbnb for more than 5 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates > 5 AND host_location LIKE '%Long Beach%';

# Find the average review score rating
SELECT COUNT(number_of_reviews) AS Num_of_Reviews, AVG(review_scores_rating) AS Avg_Review_Rating
FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Long Beach%'; 


## Pasadena, CA 
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Pasadena%';

# Find the average price of Airbnb for 2 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 2 AND 3 AND host_location LIKE '%Pasadena%';

# Find the average price of Airbnb for 4 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 4 AND 5 AND host_location LIKE '%Pasadena%';

# Find the average review score rating
SELECT COUNT(number_of_reviews) AS Num_of_Reviews, AVG(review_scores_rating) AS Avg_Review_Rating
FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Pasadena%'; 


## Beverly Hills, CA
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Beverly Hills%';

# Find the average price of Airbnb for 2 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 2 AND 3 AND host_location LIKE '%Beverly Hills%';

# Find the average price of Airbnb for 4 people
SELECT AVG(CAST(price AS UNSIGNED)) AS Avg_Price FROM Airbnb.airbnbnew
WHERE accommodates BETWEEN 4 AND 5 AND host_location LIKE '%Beverly Hills%';

# Find the average review score rating
SELECT COUNT(number_of_reviews) AS Num_of_Reviews, AVG(review_scores_rating) AS Avg_Review_Rating
FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Beverly Hills%'; 


## Export data into csv file by creating a new table
CREATE TABLE Airbnb.airbnbnew_combine (
SELECT host_location, host_is_superhost, latitude, longitude, price, number_of_reviews, review_scores_rating FROM Airbnb.airbnbnew
WHERE host_location LIKE '%Los Angeles%' OR
	  host_location LIKE '%Santa Monica%' OR
      host_location LIKE '%Long Beach%' OR
      host_location LIKE '%Pasadena%' OR
      host_location LIKE '%Beverly Hills%' AND
accommodates BETWEEN 2 AND 5);