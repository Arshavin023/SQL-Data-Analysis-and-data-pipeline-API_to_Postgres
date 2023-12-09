FROM apache/airflow:latest-python3.8

USER root
RUN apt-get update && \
    apt-get -y install git && \
    apt-get clean

USER airflow