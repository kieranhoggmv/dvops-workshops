#!/usr/bin/env bash

echo "Monitoring API Health..."
echo "200 means healthy. 500 indicates a DB issue."
echo "---------------------------------------------------"

while true; do
  VERSION=$(curl -s http://localhost:8080/health | jq -r '.version')
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)
  
  if [ "${HTTP_CODE}" == "200" ]; then
    echo -e "\033[32m[SUCCESS]\033[0m ${VERSION} - HTTP 200 - Application is serving traffic."
  elif [ "${HTTP_CODE}" == "500" ]; then
    echo -e "\033[31m[DBERR]\033[0m ${VERSION} - HTTP 500 - Database error!"
  else
    echo -e "\033[31m[ERROR]\033[0m HTTP ${HTTP_CODE} - Application error!"
  fi
  
  sleep 1
done
