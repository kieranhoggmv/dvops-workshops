#!/usr/bin/env bash

STABLE=$1

if [[ "${STABLE}" != "blue" && "${STABLE}" != "green" ]]; then
  echo "Specify which deployment to set live: blue|green"
  exit 1
fi

if docker ps | grep -q "retailstream-${STABLE}"; then
  echo $STABLE > .active
  echo "'${STABLE}' is now live!"
else
  echo "'${STABLE}' is not running!"
  exit 2
fi