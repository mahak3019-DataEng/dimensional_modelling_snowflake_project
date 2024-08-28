use database demo_sales;

create or replace schema instacart_dimensional;

create or replace storage integration instacart_stage
type = external_stage
storage_provider = 'S3'
enabled = True
storage_aws_role_arn = 'arn:aws:iam::533267281673:role/dimensional_instacart'
storage_allowed_locations = ('s3://dimensional-modelling-instacart-snowflake/instacart_market_analysis_data/');

desc integration instacart_stage; -- to get the arn values to connect to AWS role

create or replace file format demo_sales.instacart_dimensional.instacart_file_format
type = 'CSV'
null_if = ('null','NULL')
skip_header = 1
field_delimiter = ','
field_optionally_enclosed_by = '"'
empty_field_as_null = TRUE;

create or replace stage demo_sales.instacart_dimensional.instacart_final_stage
storage_integration = instacart_stage
file_format = instacart_file_format
url = 's3://dimensional-modelling-instacart-snowflake/instacart_market_analysis_data/';

list @instacart_final_stage;