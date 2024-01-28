# Data Engineering Zoomcamp  - Assignmnent One

This is the solution for the assignment of the first week in the Data Engineering Zoomcamp. During this week, several important tools and concepts relevant to Data Engineers were introduced, including Containerization using Docker, running a PostgreSQL database, and interacting with a PostgreSQL database using PgAdmin. Moreover, this chapter introduced Terraform and how it is used to interact with the Google Cloud Platform. Last but not least, a refresher on SQL was provided.










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




