#!/usr/bin/env bash

if [[ -z APP_NAME ]]; then
  echo "Missing APP_NAME!"
  exit 1
fi

if [[ -z APP_PORT ]]; then
  echo "Missing APP_PORT!"
  exit 1
fi

echo "Building the Docker image..."
docker build -t ${APP_NAME}:latest .

echo "Deploying the container..."
docker rm -f ${APP_NAME} 2> /dev/null || true
docker run --rm -d -p ${APP_PORT}:${APP_PORT} --name ${APP_NAME} ${APP_NAME}:latest

echo "Container deployed. Waiting 5 seconds for application startup..."
sleep 5
