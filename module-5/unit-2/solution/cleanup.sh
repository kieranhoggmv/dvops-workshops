#!/usr/bin/env bash

DEPLOYMENT=$1

if [[ "${DEPLOYMENT}" != "blue" && "${DEPLOYMENT}" != "green" ]]; then
  echo "Specify which deployment to cleanup: blue|green"
  exit 1
fi

STABLE="blue"
if [[ "$DEPLOYMENT" == "blue" ]]; then
  STABLE="green"
fi

echo "======================================="
echo "Initiating Automated Deployment Cleanup"
echo "======================================="

echo -n "Ensuring the '${STABLE}' application is still running... "
if docker ps | grep -q "retailstream-${STABLE}"; then
  echo "OK!"
else
  echo "'${STABLE}' is NOT running!"
  echo "Exiting..."
  exit 2
fi

echo "Cleaning up the '${DEPLOYMENT}' deployment..."
if docker ps -a | grep -q "retailstream-${DEPLOYMENT}"; then
  echo "Stopping the '${DEPLOYMENT}' container..."
  docker stop retailstream-${DEPLOYMENT} 2>&1 > /dev/null || true
  docker rm retailstream-${DEPLOYMENT} 2>&1 > /dev/null || true
fi

echo "Cleanup Complete"
