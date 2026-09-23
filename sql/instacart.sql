CREATE TABLE table_prior LIKE orders;

ALTER TABLE table_prior
ADD COLUMN product_id INT,
ADD COLUMN add_to_cart_order INT,
ADD COLUMN reordered INT;

ALTER TABLE table_prior
DROP PRIMARY KEY;

INSERT INTO table_prior
WITH t1 as (
SELECT *  
FROM orders
WHERE eval_set = 'prior')

SELECT t1.*, t_prior.product_id, t_prior.add_to_cart_order,t_prior.reordered
FROM order_products_prior AS t_prior
JOIN t1
	ON t_prior.order_id = t1.order_id;


CREATE TABLE table_train LIKE orders;

ALTER TABLE table_train
ADD COLUMN product_id INT,
ADD COLUMN add_to_cart_order INT,
ADD COLUMN reordered INT;

ALTER TABLE table_train
DROP PRIMARY KEY;

INSERT INTO table_train
WITH t2 as (
SELECT *  
FROM orders
WHERE eval_set = 'train')

SELECT t2.*, t_train.product_id, t_train.add_to_cart_order,t_train.reordered
FROM order_products_train AS t_train
JOIN t2
	ON t_train.order_id = t2.order_id;


CREATE TABLE table_test LIKE orders;
INSERT INTO table_test
SELECT *
FROM orders
WHERE eval_set = 'test';

select *
from table_prior
order by order_number;