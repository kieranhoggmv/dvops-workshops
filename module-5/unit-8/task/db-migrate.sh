#!/usr/bin/env bash

echo "Starting database migration..."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "ALTER TABLE transactions DROP COLUMN status;" || exit 1

echo "Database migration completed."

psql \
  -h localhost \
  -p ${POSTGRES_PT} \
  -U ${POSTGRES_US} \
  -d ${POSTGRES_DB} \
  -c "SELECT * FROM transactions;" || exit 1
