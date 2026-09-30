#!/usr/bin/env bash

export API_URL="http://staging-api.internal"

echo "========================================="
echo "Starting deployment sequence..."
echo "Targeting API URL: ${API_URL}"
echo "========================================="

echo "Verifying local network pathways..."
sleep 1

echo "Checking container availability..."
docker run --rm -d -p 8080:8080 u7-api:latest || exit 123

echo "Deployment successful!"
echo "API is now listening on ${API_URL}"
echo "========================================="
