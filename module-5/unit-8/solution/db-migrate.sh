#!/usr/bin/env bash

echo "Starting database migration..."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "ALTER TABLE transactions ADD COLUMN IF NOT EXISTS new_feature_data VARCHAR(255);" || exit 1

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "ALTER TABLE transactions ADD COLUMN IF NOT EXISTS new_feature_data_2 VARCHAR(255);" || exit 1

echo "Database migration completed."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "SELECT * FROM transactions;" || exit 1
