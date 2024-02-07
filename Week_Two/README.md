
# Second Homework: Workflow Orchestration

This Homework is about Workflow Orchestration using Mage open source framework. In this week, we learn how to do an ETL pipeline starting from extracting the data from an API then transforming the data using Pandas and finally loading the data into Postgres and Google Cloud.  The dataset used in the Green Taxi Dataset.
For configuring mage in your computer refer to [mage starting repositry](https://awesomeopensource.com/project/elangosundar/awesome-README-templates).

# Creating a  New pipeline
After cloning the starting mage repositry and running the docker -compose image. You can open mage through the following link.
```bash
 http://localhost:6789/

```
A new pipeline is created through the "New" button as shown in the image.

![Screenshot 2024-02-07 171121](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/f9e469e4-a114-4aff-88a4-75610f215d5c)

In my case, I have created a piple with "green_taxi_etl" as a title.

## Extracting the Data 

After creating a pipeline, open this pipline and click on the "Edit pipline" option on the left side. Add a "Data Exporter" step, then click on python, and then API option. In  `data_loader.py`, the last three months of 2020 of green taxi data is loaded. The data is available [here](https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/green/download).

After running this step, you will have an overview of the number of columns and rows present as shown below.

![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/3e29d2af-fb85-48f6-a8ae-9050fa441d57)

## Transforming the data
After extract the data, then create another block that make the following transformation for the data such as :

- Remove rows where the passenger count is equal to 0 and the trip distance is equal to zero.
- Create a new column 'lpep_pickup_date' by converting 'lpep_pickup_datetime' to a date.
- Rename columns in Camel Case to Snake Case..

This work is done in `data_transformation.py`

The numbers of rows left along with the unique values of the passenger present in the records are displayed in the screenshot.

![image](https://github.com/arwa267/Data_engineering_zoomcamp/assets/77813858/b1436886-98c9-4d47-a9ac-7ff391816ae0)

## Loading the Data
After the above transformations, the data is loaded  into both Postgres and Google Cloud Storage. Make sure to insert the credentials of the Postgres and the service key into `io_config.yaml`.

- **Loading the Data to Google Cloud Storage**:

    The script for dividing the data into partitions based on the 'lpep_pickup_date' and then loading it into a bucket in the Google Cloud storage is in `partition_gree_taxi.py`. The data will be divided into 96 partitions !!

 - **Loading the Data into Postgress**

    `Postgress_Transform.py`loads the data into a Postgres database with the credentials specifed in the `io_config.yaml` file.
 








