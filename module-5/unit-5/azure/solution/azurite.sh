#!/usr/bin/env bash
docker ps | grep azurite 2>&1 > /dev/null && exit 0

docker run --rm -d \
  --name azurite \
  -p 10000:10000 \
  -p 10001:10001 \
  -p 10002:10002 \
  mcr.microsoft.com/azure-storage/azurite:3.36.0 \
  azurite \
  --blobHost 0.0.0.0 \
  --queueHost 0.0.0.0 \
  --tableHost 0.0.0.0 \
  --skipApiVersionCheck