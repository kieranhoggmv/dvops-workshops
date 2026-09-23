#!/usr/bin/env bash

ACTION=$1
BUCKET_NAME=unit5
TEST_FILE=unit5.txt

function error {
  echo "Error encountered: ${1}"
  exit 1
}

# Ensure cli is available
aws --version 2>&1 > /dev/null || error "AWS CLI not installed!"

# Ensure required connection string is set
if [[ -z ${AWS_ENDPOINT_URL} ]]; then
  error "No AWS_ENDPOINT_URL environment variable set!"
fi

# Create the required S3 bucket if not exists
if [[ ${ACTION} == "create-bucket" ]]; then
  aws s3api head-bucket --bucket ${BUCKET_NAME} 2>/dev/null ||
    aws s3api create-bucket --bucket ${BUCKET_NAME} || error "Unable to create S3 bucket ${BUCKET_NAME}"
fi

# (Re-)Upload the required file to blob
if [[ ${ACTION} == "upload-file" ]]; then
  aws s3api put-object --bucket ${BUCKET_NAME} --key ${TEST_FILE} --body ./${TEST_FILE} ||
    error "File upload failed!"
fi

# Check if the required file exists
if [[ ${ACTION} == "check-file-exists" ]]; then
  aws s3api head-object --bucket ${BUCKET_NAME} --key ${TEST_FILE} 2>/dev/null ||
    error "${TEST_FILE} not found in S3!"
fi

# Ensure the uploaded file matches local
if [[ ${ACTION} == "validate-checksum" ]]; then
  aws s3api get-object --bucket ${BUCKET_NAME} --key ${TEST_FILE} /tmp/${TEST_FILE}

  BLOB_SUM=$(sha256sum /tmp/${TEST_FILE} | awk '{print $1}')

  if [[ ${CHECKSUM} == ${BLOB_SUM} ]]; then
    echo "Checksums matched! ${CHECKSUM} == ${BLOB_SUM}"
  else
    error "Checksums do not match! ${CHECKSUM} != ${BLOB_SUM}"
  fi
fi

exit 0
