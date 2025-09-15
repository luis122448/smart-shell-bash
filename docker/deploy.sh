#!/bin/bash
# Description: Deploy the application

# Stop the application
sudo docker compose down

# Pull the latest images
sudo docker compose pull

# Build and run the application
sudo docker compose up --build --force-recreate --no-deps -d
