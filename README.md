# car_loan_analysis_and_batch_data_pipeline_for_daily_currency_rates

![ERD Data Model](https://github.com/Arshavin023/car_loan_analysis_and_batch_data_pipeline_for_daily_currency_rates/assets/77532336/ecdcdb09-4dbb-4ebb-8077-5bf5158b82b4)

## Workflows
### Question One: SQL Analysis
1. Create ERD model with lucid.app and obtain create table SQL statements
2. Download postgreSQL database (latest version), install and create a password
3. Launch PgAdmin to access PostgreSQL database and login to server with password created earlier
4. Create a database named 'autochek'. In the database, create a schema name 'staging'![Uploading ERD Data Model.jpeg…]()

5. Utilize create SQL statements from step one to create tables, ensuring referential integrity
6. Load CSV files appropriately into created tables
7. Run SQL analysis files in the 'question_one_sql_analysis' and obtain results

### Question One: SQL Analysis
1. Download docker-desktop and install, ensuring WSL is appropriately installed
2. Launch Docker-Desktop and login with credentials
3. create Dockerfile file
4. create docker-compose.yml file
5. right-click on Dockerfile file and select 'build image'
6. if step 5 is successful, an airflow folder appears. Navigate to it and create a folder named 'dags'
7. Inside the dags folder, create dags (python files) and save
8. if step 5 is successful, right click docker-compose.yml file and select 'compose up'
9. Open Docker-Desktop, confirm is images are running. If yes, navigate to containers and access the airflow UI through the provided URL with port: 8080:8080
10. To login to Airflow UI, obtain password from the 'standalone_admin_password.txt' file in airflow folder
11. Login to Airflow UI, click on Admin at the top center, select Variables and saved the API_ID and API_KEY. click on Admin again, select Connections and supply the correct PostgreSQL credentials and save.
Note: when running PostgreSQL through Docker, the host should be 'host.docker.internal' and not 'localhost'
12. Now click on the dag and trigger it manually.








