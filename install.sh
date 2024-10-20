#!/bin/bash

# Verify if the variable is not defined
if [ -z "$SERVER_HOST" ] && [ -z "$SERVER_USER" ]; 
then
    echo "The SERVER_HOST or SERVER_USER variable is not defined in the sustem environment!" >&2
    exit 1000
fi

if [ -z "$DATABASE_USERNAME" ] && [ -z "$DATABASE_PASSWORD" ]; 
then
    echo "The DATABASE USERNAME or DATABASE_PASSWORD variable is not defined in the system environment!" >&2
    exit 1000
fi

# Verify if the network exists
if ! sudo docker network inspect smart-shell-net &>/dev/null; then
    sudo docker network create --driver bridge smart-shell-net
else
    echo "La red 'smart-shell-net' ya existe."
fi

# Stop containers
sudo docker stop smart-shell-postgres
sudo docker stop smart-shell-redis
sudo docker stop smart-shell-mongo
sudo docker stop smart-shell-springboot
sudo docker stop smart-shell-angular

# Chmod scripts
sudo chmod +x ./scripts/install/postgres.sh
sudo chmod +x ./scripts/install/redis.sh
sudo chmod +x ./scripts/install/mongo.sh
sudo chmod +x ./scripts/install/java.sh
sudo chmod +x ./scripts/install/angular.sh

# Execute installation scripts
sudo bash `./scripts/install/postgres.sh`
sudo bash `./scripts/install/redis.sh`
sudo bash `./scripts/install/mongo.sh`
sudo bash `./scripts/install/java.sh`
sudo bash `./scripts/install/angular.sh`