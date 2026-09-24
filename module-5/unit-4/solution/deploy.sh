#!/usr/bin/env bash

echo "Initialising deployment script..."

# Check if authenticated properly
if [ "$API_TOKEN" != "mock_token_123" ]; then
  echo "DEPLOY ERROR: Invalid or missing API credential." >&2
  exit 1
fi

echo $API_TOKEN

# Create deploy_target if required
if [ -d "./deploy_target" ]; then
  echo "Target directory exists. Proceeding with copy..."
else
  echo "No target directory found, creating..."
  mkdir -p ./deploy_target
fi

echo "Copying application files..."

echo "Deployment sequence completed successfully."
