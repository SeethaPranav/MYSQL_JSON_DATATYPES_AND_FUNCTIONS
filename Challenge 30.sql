CREATE DATABASE challenge30;
USE challenge30;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_info JSON
);

INSERT INTO products (product_info) VALUES
('{"name": "Smartphone", "price": 699, "stock": 50, "ratings": {"avg_rating": 4.5, "reviews": 150}, "categories": ["electronics", "mobile"]}'),
('{"name": "Laptop", "price": 1200, "stock": 20, "ratings": {"avg_rating": 4.7, "reviews": 200}, "categories": ["electronics", "computers"]}'),
('{"name": "Headphones", "price": 150, "stock": 35, "ratings": {"avg_rating": 4.0, "reviews": 80}, "categories": ["electronics", "audio"]}'),
('{"name": "Tablet", "price": 400, "stock": 15, "ratings": {"avg_rating": 4.2, "reviews": 90}, "categories": ["electronics", "mobile"]}');

SELECT * FROM products;

#1. Extract the product name from the product_info column for all products.
SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products;

#2. Retrieve the average rating (avg_rating) for the "Smartphone".
SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.ratings.avg_rating')) AS avg_rating 
FROM products
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Smartphone';

#3. List all products that have stock greater than 30.
SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.stock')) > 30;

#4. Find products that belong to the "computers" category.
SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products
WHERE JSON_CONTAINS(JSON_EXTRACT(product_info, '$.categories'), '"computers"');

#5. Update the price of "Headphones" to $180.
UPDATE products
SET product_info = JSON_SET(product_info, '$.price', 180)
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Headphones';

set sql_safe_updates =0;

#6. Remove the "reviews" field from the ratings object for all products.
UPDATE products
SET product_info = JSON_REMOVE(product_info, '$.ratings.reviews');

