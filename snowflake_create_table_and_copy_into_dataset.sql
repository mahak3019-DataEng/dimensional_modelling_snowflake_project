use database demo_sales;
use schema demo_sales.instacart_dimensional;

create or replace table aisles (
aisle_id integer,
aisle varchar(255)
);
copy into demo_sales.instacart_dimensional.aisles
from @instacart_final_stage/aisles.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.aisles;


create or replace table departments (
department_id integer,
department varchar(255)
);
copy into demo_sales.instacart_dimensional.departments
from @instacart_final_stage/departments.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.departments;


create or replace table order_products__prior (
order_id integer,
product_id integer,
add_to_cart_order integer,
reordered integer
);
copy into demo_sales.instacart_dimensional.order_products__prior
from @instacart_final_stage/order_products__prior.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.order_products__prior;


create or replace table order_products__train (
order_id integer,
product_id integer,
add_to_cart_order integer,
reordered integer
);
copy into demo_sales.instacart_dimensional.order_products__train
from @instacart_final_stage/order_products__train.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.order_products__train;

create or replace table orders (
order_id integer,
user_id integer,
eval_set varchar(255),
order_number integer,
order_dow integer,
order_hour_of_day integer,
days_since_prior_order integer
);
copy into demo_sales.instacart_dimensional.orders
from @instacart_final_stage/orders.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.orders;

create or replace table products (
product_id integer,
product_name varchar(255),
aisle_id integer,
department_id integer
);
copy into demo_sales.instacart_dimensional.products
from @instacart_final_stage/products.csv
file_format = (format_name = 'demo_sales.instacart_dimensional.instacart_file_format' )
on_error ='continue';

select * from demo_sales.instacart_dimensional.products;