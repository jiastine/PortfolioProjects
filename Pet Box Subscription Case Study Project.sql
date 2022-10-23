# Data Validation
## Make sure there are no duplicates in the dataset (879 product_id)
SELECT COUNT(DISTINCT(product_id)) AS Num_of_product
FROM Pet_Box_Project.pet_sales;
# Make sure Product_ID is in CHAR data type (Need to convert from INT to CHAR)
SHOW FIELDS FROM Pet_Box_Project.pet_sales;
ALTER TABLE Pet_Box_Project.pet_sales
MODIFY product_id TEXT;

## Check that there are 11 product categories in the dataset
SELECT COUNT(DISTINCT(product_category)) AS Num_of_product_category
FROM Pet_Box_Project.pet_sales;
# Make sure product_category is in CHAR data type
SHOW FIELDS FROM Pet_Box_Project.pet_sales;

## Convert Sales from numeric to integer for better analysis in the future
# Use update statements to remove the dollar sign and comma from the sales
# Alter and modify the table to convert sales from TEXT to INT
UPDATE Pet_Box_Project.pet_sales
SET sales = REPLACE(sales, '$', '');
UPDATE Pet_Box_Project.pet_sales
SET sales = REPLACE(sales, ',', '');
ALTER TABLE Pet_Box_Project.pet_sales
MODIFY sales INT;
SHOW FIELDS FROM Pet_Box_Project.pet_sales;
# The above also checks the data type of each column 
    
## Check that there are no duplicate vendor_id in the dataset (833 vendor_id)
SELECT COUNT(DISTINCT(vendor_id))
FROM Pet_Box_Project.pet_sales;
# Make sure vendor_id has CHAR data type
SHOW FIELDS FROM Pet_Box_Project.pet_sales;

## Check that there are 5 pet size categories 
SELECT COUNT(DISTINCT(pet_size))
FROM Pet_Box_Project.pet_sales;
# Make sure pet_size has CHAR data type
SHOW FIELDS FROM Pet_Box_Project.pet_sales;

## Check that there are 4 pet types: cat, dog, fish, bird
SELECT DISTINCT(pet_type)
FROM Pet_Box_Project.pet_sales;
# Delete hamster and rabbit pet types from the dataset
DELETE FROM Pet_Box_Project.pet_sales
WHERE pet_type IN ('hamster', 'rabbit');
SELECT DISTINCT(pet_type)
FROM Pet_Box_Project.pet_sales;
# How many rows of records are in this dataset after removing hamster and rabbit? (833)
SELECT COUNT(*)
FROM Pet_Box_Project.pet_sales;
# Make sure pet_type has CHAR data type
SHOW FIELDS FROM Pet_Box_Project.pet_sales;

## Check that rating is on a 10 point scale
SELECT DISTINCT(rating)
FROM Pet_Box_Project.pet_sales;
# Make sure rating has INT data type
SHOW FIELDS FROM Pet_Box_Project.pet_sales;

## Check that Rebuy is binary (should be 1 or 0)
SELECT DISTINCT(re_buy)
FROM Pet_Box_Project.pet_sales;
SHOW FIELDS FROM Pet_Box_Project.pet_sales;
# Rebuy is currently a INT type and needs to convert to BINARY
ALTER TABLE Pet_Box_Project.pet_sales
MODIFY re_buy BINARY;

## Check one more time that all of the columns are in their appropriate data types
SHOW FIELDS FROM Pet_Box_Project.pet_sales;


# Data Discovery and Visualization 
## How many products are being purchased more than once? 
SELECT COUNT(re_buy) AS Num_of_product
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1;

## Which product category has the most puchases?
SELECT product_category, COUNT(re_buy) AS Num_of_product
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1
GROUP BY product_category
ORDER BY Num_of_product DESC;

## Do the products being purchased again have better sales than others?
# Equipment (purchased again) has a total sale of 8,660,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1
GROUP BY product_category
ORDER BY total_sales DESC;
# Snack (purchased once) has a total sale of 9,204,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 0
GROUP BY product_category
ORDER BY total_sales DESC;

## What products are more likely to be purchased again for different types of pets?
## Look at different pet_types and their product_categories and see which had the most sales 
# For dogs, Equipment (purchased again) has the most sales of 3,317,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'dog'
GROUP BY product_category
ORDER BY total_sales DESC;
# For dogs, Snacks (purchased once) has the most sales of 3,101,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 0 AND pet_type = 'dog'
GROUP BY product_category
ORDER BY total_sales DESC;

# For cats, Equipment (purchased again) has the most sales of 3,485,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'cat'
GROUP BY product_category
ORDER BY total_sales DESC;
# For cats, Equipment (purchased once) has the most sales of 3,749,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 0 AND pet_type = 'cat'
GROUP BY product_category
ORDER BY total_sales DESC;

# For fish, Toys (purchased again) has the most sales of 992,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'fish'
GROUP BY product_category
ORDER BY total_sales DESC;
# For fish, Equipment (purchased once) has the most sales of 1,296,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 0 AND pet_type = 'fish'
GROUP BY product_category
ORDER BY total_sales DESC;

# For bird, Snack (purchased again) has the most sales of 1,019,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'bird'
GROUP BY product_category
ORDER BY total_sales DESC;
# For bird, Equipment (purchased once) has the most sales of 1,301,000
SELECT product_category, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 0 AND pet_type = 'bird'
GROUP BY product_category
ORDER BY total_sales DESC;

## For each pet type, we can also look at each product categories and their ratings 
# For dog, Food (purchased again) has the highest average rating of 8.2353
SELECT product_category, AVG(rating) AS avg_rating
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'dog'
GROUP BY product_category
ORDER BY avg_rating DESC;

# For cat, Bedding (purchased again) has the highest average rating of 8.2222
SELECT product_category, AVG(rating) AS avg_rating
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'cat'
GROUP BY product_category
ORDER BY avg_rating DESC;

# For fish, Equipment and Housing (purchased again) has the highest average rating of 7.0000
SELECT product_category, AVG(rating) AS avg_rating
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'fish'
GROUP BY product_category
ORDER BY avg_rating DESC;

# For bird, Housing (purchased again) has the highest average rating of 9.0000
SELECT product_category, AVG(rating) AS avg_rating
FROM Pet_Box_Project.pet_sales
WHERE re_buy = 1 AND pet_type = 'bird'
GROUP BY product_category
ORDER BY avg_rating DESC;


## Create at least two different data visualizations to demonstrate the characteristics of variables
## Which pet type had the most sales?
SELECT pet_type, SUM(sales) AS total_sales
FROM Pet_Box_Project.pet_sales
GROUP BY pet_type
ORDER BY total_sales DESC;

## How many records per pet_type?
SELECT pet_type, COUNT(product_id) AS num_of_sales
FROM Pet_Box_Project.pet_sales
GROUP BY pet_type
ORDER BY Num_of_sales DESC;

## What are the ratings like for the sales?
## How many products per pet_type have ratings 9 and above?
SELECT pet_type, COUNT(rating) AS num_of_ratings
FROM Pet_Box_Project.pet_sales
WHERE rating >= 9
GROUP BY pet_type;
## How many ratings of 9 and above per Product category?
SELECT product_category, COUNT(rating) as num_of_ratings
FROM Pet_Box_Project.pet_sales
WHERE rating >= 9
GROUP BY product_category
ORDER BY num_of_ratings DESC;

## How are the ratings in general?
SELECT rating, COUNT(rating) AS num_of_ratings
FROM Pet_Box_Project.pet_sales
GROUP BY rating
ORDER BY rating DESC;

# Average rating per pet_type and per category
SELECT pet_type, product_category, AVG(rating) AS avg_rating
FROM Pet_Box_Project.pet_sales
WHERE pet_type = 'bird'
GROUP BY product_category;

# Average price of each product category by Pet Types
SELECT product_category, AVG(price)
FROM Pet_Box_Project.pet_sales
WHERE pet_type = 'dog'
GROUP BY product_category;

## Convert re-buy to INT to download dataset
#ALTER TABLE Pet_Box_Project.pet_sales
#MODIFY re_buy INT;
#SELECT * FROM Pet_Box_Project.pet_sales;