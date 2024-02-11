-- Create a Table in Bigquery that combines the green taxi data for 2022 that are present in parquet files in the Google Cloud Storage
CREATE OR REPLACE EXTERNAL TABLE `taxiridesny.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://green_taxi_2022_db/green_tripdata_2022-*.parquet']
);


#Create a materialized table in the Big query 
CREATE OR REPLACE TABLE taxiridesny.external_green_tripdata_non_part AS
SELECT * FROM taxiridesny.external_green_tripdata;

#Get the Number of rows in the materialized table 
select COUNT(*) from  taxiridesny.external_green_tripdata_non_part

#Getting the distinct number of Pulocation in both materialized and external table

## Materialized Table
select  COUNT(DISTINCT(PULocationID))
from taxiridesny.external_green_tripdata_non_part

##External Table 

select  COUNT(DISTINCT(PULocationID))
from taxiridesny.external_green_tripdata

#getting the number of records with zero fare amount

select  COUNT(*)
from taxiridesny.external_green_tripdata_non_part t
where t.fare_amount=0;


#Creating a partition and cluster table
CREATE OR REPLACE TABLE taxiridesny.external_green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM `taxiridesny.external_green_tripdata`;



#query in non partitioned data
select  COUNT(DISTINCT(PULocationID))
from taxiridesny.external_green_tripdata_non_part
where DATE(lpep_pickup_datetime)>= DATE("2022-6-1") and 
DATE(lpep_pickup_datetime) <= DATE("2022-6-30")


#query in partitioned data
select  COUNT(DISTINCT(PULocationID))
from taxiridesny.external_green_tripdata_partitoned_clustered
where DATE(lpep_pickup_datetime)>= DATE("2022-6-1") and 
DATE(lpep_pickup_datetime) <= DATE("2022-6-30")