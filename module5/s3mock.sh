#!/usr/bin/env bash
docker ps | grep s3mock 2>&1 > /dev/null && exit 0

docker run --rm -d \
  --name s3mock \
  -p 9090:9090 \
  adobe/s3mock
