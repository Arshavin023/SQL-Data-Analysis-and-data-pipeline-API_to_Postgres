## car_loan_analysis_and_batch_data_pipeline_for_daily_currency_rates

![ERD Data Model](https://github.com/Arshavin023/car_loan_analysis_and_batch_data_pipeline_for_daily_currency_rates/assets/77532336/ecdcdb09-4dbb-4ebb-8077-5bf5158b82b4)

### Workflows
### STEPS:
Clone the repository
```bash
https://github.com/Arshavin023/car_loan_SQL_analysis_and_scheduled_currency_rates_extraction_with_Python
```
### Question One: SQL Analysis
1. Download postgreSQL database (latest version), install and create a password
2. Launch PgAdmin to access PostgreSQL database and login to server with password created earlier
3. Create a database named 'autochek'. In the database, create a schema name 'staging'
4. Utilize erd_table_creations.sql from question_one_sql_analysis folder to create tables, ensuring referential integrity
6. Load CSV files appropriately into created tables
7. Run SQL analysis files in the 'question_one_sql_analysis' and obtain results

### Question Two: Data Pipeline Orchestration with Docker-Airflow
1. Download docker-desktop and install, ensuring WSL is appropriately installed
2. Launch Docker-Desktop and login with credentials
3. right-click on Dockerfile in question_two_airflow_docker folder and select 'build image'
4. right click docker-compose.yml file and select 'compose up'
5. Open Docker-Desktop (running in background) and confirm is images are running. If yes, navigate to containers and access Airflow UI through the provided URL with port: 8080:8080
6. To login to Airflow UI, obtain password from the 'standalone_admin_password.txt' file in airflow folder
7. Login to Airflow UI, click on Admin at the top center, select Variables and save the API_ID and API_KEY obtained from ```https://www.xe.com/xecurrencydata/```.
8. Click on Admin again, select Connections, supply the correct PostgreSQL credentials and save.
9. Now click on the dag and trigger it manually.

#### Note: when running PostgreSQL through Docker, the host credential on Airflow UI should be 'host.docker.internal' and not 'localhost'

<img width="943" alt="success" src="https://github.com/Arshavin023/SQL-Data-Analysis-and-data-pipeline-API_to_Postgres/assets/77532336/1b06b10e-18fa-49ad-b7b3-f5f6d43206c0">






