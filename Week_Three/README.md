
## Third Week in Data Engineering Zoomcamp

In this week, the basics of Bigquery is introduced such as its internals, its advantages along with its best usages. 
 

 ## Creating an External Table for Green Taxi Data in 2022

 The Green Taxi data for 2022 can be obtained  through [this link](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page). 

 The first step for creating this table is to upload the 12 parquet sheets into a google storage bucket titled as `green_taxi_2022_db` as shown below.

 ![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/13f8e55e-0dfa-4827-a2e6-d3a95189170d)

For creating an external table that contains the data of these parquet file is done through the following code:

```SQL
CREATE OR REPLACE EXTERNAL TABLE `taxiridesny.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://green_taxi_2022_db/green_tripdata_2022-*.parquet']
)
```

When getting more details about this table, we will notice that there is no information about the size or the number of rows in this table, this is because this is an external table that is present in google cloud storage and not in google big query.

## Creating a Materialized Table
 
Creating a Materialized copy of this external table without partitioning, the following query is used.

```SQL
CREATE OR REPLACE TABLE taxiridesny.external_green_tripdata_non_part AS
SELECT * FROM taxiridesny.external_green_tripdata;
```
When going to the Storage info of this table, all relevant information will appear.

![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/a755f4a7-c948-44e3-8bc8-2ae159e25184)


- **For getting the distinct number of pick up locations in the Materialized table**

  ```SQL
  select  COUNT(DISTINCT(PULocationID))
  from taxiridesny.external_green_tripdata_non_part
  ```
  The amount of data processed can be retrieved from the Job information.

  ![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/b9b9d2a9-26ec-4717-a9d5-0a8f1e6d2256)


- **For getting  the numeber of records with  fare amount equal to zero**

  ```SQL
 select  COUNT(*)
from taxiridesny.external_green_tripdata_non_part 
where fare_amount=0
```


## Better Ways for an Effective Data Retrieval in BigQuery

In most query retrieval for out table, the filter is performed on the location pick up date and ordered by the pickup location. Therefore, for a better performance, this table is partitioned based on the pickup date and clustered by the pick up location.

This is done using the following query:

  ```SQL
CREATE OR REPLACE TABLE taxiridesny.external_green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM `taxiridesny.external_green_tripdata`;
  ```

## Comparison Between performance for partitioned and not partitioned table

For retrieving the number of pick up locations in the month of June, the query used for the  partitioned data is

  ```SQL
select  COUNT(DISTINCT(PULocationID))
from taxiridesny.external_green_tripdata_partitoned_clustered
where DATE(lpep_pickup_datetime)>= DATE("2022-6-1") and 
DATE(lpep_pickup_datetime) <= DATE("2022-6-30")
  ```

The size of the data proccesed is 1.12 MB.

![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/54726484-35c4-4c90-9d8f-7b6ef478d2f9)

Applying the same query for the non partitioned table, the size of the data proccesed is 12.81 MB.
