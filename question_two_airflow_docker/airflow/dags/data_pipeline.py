from datetime import datetime, timedelta
import pandas as pd
from xecd_rates_client import XecdClient
from airflow.decorators import dag, task
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.models import Variable
from airflow.utils.dates import days_ago
import logging
import traceback
import numpy as np

@dag(
    'currency_exchange_rates_extraction',
    default_args={
        'owner': 'uchejudennodim@gmail.com',
        'depends_on_past': False,
        'start_date': days_ago(0),
        'retries': 1,
        'retry_delay': timedelta(minutes=5),
    },
    description='DAG to extract daily currency rates and load into PostgreSQL',
    schedule_interval='0 1,23 * * *',
    concurrency=1,
)
def daily_extraction_dag():

    @task()
    def connect_to_api_and_extract(api_id: str, api_key:str, country_dict:dict) -> dict:
        try:
            api_conn = XecdClient(api_id, api_key)
            dictionary = {}
            
            for country, currency in country_dict.items():
                columns = ['timestamp', 'currency_from', 'USD_to_currency_rate', 'currency_to_USD_rate', 'currency_to']
                current_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                convert_to = api_conn.convert_to(currency, "USD", 1)
                convert_from = api_conn.convert_from("USD", currency, 1)
                USD_to_currency_rate = convert_to['from'][0]['mid']
                currency_to_USD_rate = convert_from['to'][0]['mid']
                daily_rate = [[current_datetime, "USD", USD_to_currency_rate, currency_to_USD_rate, currency]]
                df = pd.DataFrame(daily_rate, columns=columns)
                dictionary[country] = df
                logging.info(f'Dataframe for {country} successfully created and added to dictionary')
            return dictionary

        except Exception as e:
            logging.error(f"Exception occurred: {str(e)}")
            logging.error(f"Timestamp: {datetime.now()}")
            logging.error(f"Traceback: {traceback.format_exc()}")

    @task()
    def connect_to_postgres_and_load_data(dataframe_dict:dict, conn_id:str) -> str:
        try:
            for table_name, df in dataframe_dict.items():
                # Convert the DataFrame to a list of tuples for bulk insert
                data_tuples = [tuple(map(lambda x: int(x) if isinstance(x, np.int64) else x, row)) for row in df.to_numpy()]

                # Use PostgresHook to execute the insert query
                hook = PostgresHook(postgres_conn_id=conn_id)
                hook.insert_rows(table=f'staging.{table_name}', rows=data_tuples)
                logging.info(f'Data successfully inserted into staging.{table_name} table')
                
            return 'data successfully inserted into PostgreSQL and workflow completed'
            
        except Exception as e:
            logging.error(f"Exception occurred: {str(e)}")
            logging.error(f"Timestamp: {datetime.now()}")
            logging.error(f"Traceback: {traceback.format_exc()}")

    country_dict = {'Nigeria': 'NGN', 'Ghana': 'GHS', 
                    'Kenya': 'KES', 'Uganda': 'UGX',
                    'Morocco': 'MAD', "Ivory_Coast": 'XOF', 
                    'Egypt': 'EGP'}

    api_id = Variable.get("ACCOUNT_ID")
    api_key = Variable.get("API_KEY")
    postgres_conn_id = 'postgres_conn_id'  # Specify the Airflow connection ID for PostgreSQL

    # Task 1: Connect to API and Extract Daily Rates
    extract_task = connect_to_api_and_extract(api_id, api_key, country_dict)
    # Task 2: Load Data into PostgreSQL
    load_task = connect_to_postgres_and_load_data(extract_task, postgres_conn_id)

    extract_task >> load_task

daily_extraction_dag()