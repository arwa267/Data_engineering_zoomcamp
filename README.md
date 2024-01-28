
# Data Engineering Zoomcamp  - Assignmnent One

This is the solution for the assignment of the first week in the Data Engineering Zoomcamp. During this week, several important tools and concepts relevant to Data Engineers were introduced, including Containerization using Docker, running a PostgreSQL database, and interacting with a PostgreSQL database using PgAdmin. Moreover, this chapter introduced Terraform and how it is used to interact with the Google Cloud Platform. Last but not least, a refresher on SQL was provided.

The data used in this homework is the green taxi dataset for the month of September 2019. The main dataset can be downloaded from [here](https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz), and the dataset of the zones of these taxis can be downloaded from [here](https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv) as well. 












## Question One: 

After installing docker, and to get more information about running an image, run the following command

```bash
  docker run --help
```
A list of all the options and  commands will be provided as shown in the Screenshot below.

![Screenshot 2024-01-28 135839](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/99e62dcc-5546-48c7-9c04-578ba0b0f5f0)

If you want to automatically remove the container upon exiting, use the following command: 

![Screenshot 2024-01-28 140158](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/afed5e28-989a-4d71-bf28-2ce01c6950f2)


## Question Two: 
 For running a python:3.9 image in an interactive mode  with a bash entrypoint. Run the following command:

 
```bash
  docker run  -it --entrypoint=bash python:3.9 
```
if you haven't ran this command before then it will take sometime to download this image. For knowing the version of the wheel package in this version, then run the following command:

```bash
  wheel --version
```

## Questions Three, Four, Five, and Six:
Initially, we have to create a postgress database and add the dataset of the green taxi into this database. Also, we will use pgadmin to interact with this postgress database using SQL queries.

The command used to run a postgress database:


```bash
 docker run -it -e POSTGRES_USER="root" -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="green_taxi" -v c:/users/user/desktop/dataengineering/green_trip_data:/var/lib/postgresql/data -p 5432:5432 --network=pg-network --name=pg-database postgres:13
 ```

 The command to run a pgadmin instance and connecting it with the network of the postgress image:

```bash
docker run -it -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" -e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 --network=pg-network  --name pgadmin-2 dpage/pgadmin4
 ```
After running both instances, the data from the two datasets mentioned are uploaded to the postgres database. This is done in the jupyeter notebook `Connecting with Postgres.ipynb` where 
`Sqlalchemy` package is used to connect with Postgres.


Now to open a `Pgadmin`, open the browser through the following link:

```bash
http://localhost:8080/
 ```

 The following page will open where you have to insert the email and password that were specified when running the pgadmin image.

 ![Screenshot 2024-01-28 160403](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/5b7a14a6-aa8c-4513-8c25-a91c73474627)

 Click on add a new server, and add the credentials of the postgres database that was created earlier in the connection tab. Now we can write an sql query to interact with the database. The queries used to answer the coming four questions are present in `Queries_Green_Taxi.sql` 

 - Question 3: How many taxi trips were totally made on September18th 2019? The Answer is : **15612** 
 - Question 4: Which was the pick up day with the largest trip distance? The Answer is:** 2019-09-26**
 - Question 5: Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000? Answer: ** "Brooklyn" "Manhattan" "Queens"**
 - Question 6: For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip? Answer is : **JFK Airport**

