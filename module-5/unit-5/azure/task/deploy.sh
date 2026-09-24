#!/usr/bin/env bash

ACTION=$1
CONTAINER_NAME=unit5
TEST_FILE=unit5.txt

function error {
  echo "Error encountered: ${1}"
  exit 1
}

# Ensure cli is available
az version 2>&1 > /dev/null || error "Azure CLI not installed!"

# Ensure required connection string is set
if [[ -z ${AZURE_STORAGE_CONNECTION_STRING} ]]; then
  error "No AZURE_STORAGE_CONNECTION_STRING environment variable set!"
fi

# Create the required container if not exists
if [[ ${ACTION} == "create-container" ]]; then
  EXISTS=$(az storage container exists -n ${CONTAINER_NAME} | jq -r '.exists')
  if [[ ${EXISTS} == "false" ]]; then
    CREATED=$(az storage container create -n ${CONTAINER_NAME} | jq -r '.created')
    if [[ ${CREATED} == "false" ]]; then
      error "Unable to create container ${CONTAINER_NAME}"
    fi
  fi
fi

# (Re-)Upload the required file to blob
if [[ ${ACTION} == "upload-file" ]]; then
  az storage blob upload \
    -c ${CONTAINER_NAME} \
    -f ${TEST_FILE} \
    -n ${TEST_FILE} \
    --overwrite

  if [[ $? -ne 0 ]]; then
    error "File upload failed!"
  fi
fi

# Check if the required file exists
if [[ ${ACTION} == "check-file-exists" ]]; then
  EXISTS=$(az storage block exists -c ${CONTAINER_NAME} -n ${TEST_FILE} | jq -r '.exists')
  if [[ ${EXISTS} == "true" ]]; then
    echo "Found ${TEST_FILE} in Blob!"
  else
    error "${TEST_FILE} not found in Blob!"
  fi
fi

# Ensure the uploaded file matches local
if [[ ${ACTION} == "validate-checksum" ]]; then
  az storage blob download \
    -c ${CONTAINER_NAME} \
    -n ${TEST_FILE} \
    -f /tmp/${TEST_FILE} || error "Unable to download ${TEST_FILE} from blob!"

  BLOB_SUM=$(sha256sum /tmp/${TEST_FILE} | awk '{print $1}')

  if [[ ${CHECKSUM} == ${BLOB_SUM} ]]; then
    echo "Checksums matched! ${CHECKSUM} == ${BLOB_SUM}"
  else
    error "Checksums do not match! ${CHECKSUM} != ${BLOB_SUM}"
  fi
fi

exit 0