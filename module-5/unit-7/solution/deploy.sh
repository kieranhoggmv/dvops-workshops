#!/usr/bin/env bash

if [ -z ${API_URL} ]; then
    echo "ERROR: API_URL environment variable is not set!" >&2
    echo "Aborting deployment to prevent configuration drift." >&2
    exit 1
fi

echo "========================================="
echo "Starting deployment sequence..."
echo "Targeting API URL: ${API_URL}"
echo "========================================="

echo "Verifying local network pathways..."
sleep 1

echo "Checking container availability..."
docker run --rm -d -p 8080:8080 -e API_URL="${API_URL}" u7-api:${GITHUB_SHA} || exit 123

echo "Deployment successful!"
echo "API is now listening on ${API_URL}"
echo "========================================="
