# MYSQL_JSON_DATATYPES_AND_FUNCTIONS
Exploring MySQL's JSON data type and functions to manage and query semi-structured data effectively, enhancing data flexibility and retrieval capabilities.

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

![products](https://github.com/user-attachments/assets/060d8a9e-d7e8-4785-a457-d18f047a9306)

#1. Extract the product name from the product_info column for all products.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products;

![q1](https://github.com/user-attachments/assets/c042ceb9-774b-4403-9d5d-d1a755881837)

#2. Retrieve the average rating (avg_rating) for the "Smartphone".

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.ratings.avg_rating')) AS avg_rating 
FROM products
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Smartphone';

![q2](https://github.com/user-attachments/assets/1291bd36-9ff0-479d-ac99-c7ec9b04a1d9)

#3. List all products that have stock greater than 30.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.stock')) > 30;

![q3](https://github.com/user-attachments/assets/0ffa38a4-3ec1-4a44-8ddc-0450e66c440e)

#4. Find products that belong to the "computers" category.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name 
FROM products
WHERE JSON_CONTAINS(JSON_EXTRACT(product_info, '$.categories'), '"computers"');

![q4](https://github.com/user-attachments/assets/65347bbd-a21a-4d33-ad14-97f1fbdd2243)

#5. Update the price of "Headphones" to $180.

UPDATE products
SET product_info = JSON_SET(product_info, '$.price', 180)
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Headphones';

set sql_safe_updates =0;

![q5](https://github.com/user-attachments/assets/e556e687-39bf-40d1-99d1-dc2fc85bb941)

#6. Remove the "reviews" field from the ratings object for all products.

UPDATE products
SET product_info = JSON_REMOVE(product_info, '$.ratings.reviews');

![q6](https://github.com/user-attachments/assets/a00c6345-9bce-4aaa-bd56-53266da1893e)



