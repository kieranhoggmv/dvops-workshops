#!/usr/bin/env bash

ACTIVE=blue
PORT=8080

if [ -f .active ]; then
  ACTIVE=$(cat .active)
fi

if [[ "${ACTIVE}" == "green" ]]; then
  PORT=8081
fi

echo "'${ACTIVE}' is currently live!"
echo -n "Healthcheck: "
curl -s -f localhost:${PORT}