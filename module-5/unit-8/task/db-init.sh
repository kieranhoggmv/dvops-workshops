#!/usr/bin/env bash

pg_isready \
  -h localhost \
  -p ${POSTGRES_PT} \
  -d ${POSTGRES_DB} \
  -U ${POSTGRES_US} || exit 1

echo "Starting database initialisation..."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "CREATE TABLE transactions (status VARCHAR(255));" || exit 1

echo "Database init completed."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "SELECT * FROM transactions;" || exit 1
