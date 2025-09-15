#!/bin/bash
# Description: Deploy the application

# Stop the application
sudo docker compose down

# Build and run the application
sudo docker compose up --build --force-recreate --no-deps -d
