#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

# Check if DATA_STORAGE_PATH is set
if [ -z "$DATA_STORAGE_PATH" ]; then
  echo "Error: DATA_STORAGE_PATH is not set in .env file."
  exit 1
fi

# Clear directories
rm -rf "${DATA_STORAGE_PATH}/smart-shell-postgres/data/"*
rm -rf "${DATA_STORAGE_PATH}/smart-shell-postgres/logs/"*
rm -rf "${DATA_STORAGE_PATH}/smart-shell-postgres/backups/"*
rm -rf "${DATA_STORAGE_PATH}/smart-shell-postgres/configurations/"*
rm -rf "${DATA_STORAGE_PATH}/smart-shell-mongo/data/"*

echo "Directories cleared successfully."
