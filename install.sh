#!/bin/bash

# Charge environment variables
source /etc/environment

# Verify if the variable is not defined
if [ -z "$SERVER_LOCAL_HOST" ]; 
then
    echo "The SERVER_LOCAL_HOST or SERVER_LOCAL_USER variable is not defined in the system environment!" >&2
    exit 1000
fi

if [ -z "$DATABASE_USERNAME" ] && [ -z "$DATABASE_PASSWORD" ]; 
then
    echo "The DATABASE USERNAME or DATABASE_PASSWORD variable is not defined in the system environment!" >&2
    exit 1000
fi

if [ -z "$SMART_SHELL_POSTGRES_PORT" ] && [ -z "$SMART_SHELL_REDIS_PORT" ] && [ -z "$SMART_SHELL_MONGO_PORT" ] && [ -z "$SMART_SHELL_SPRINGBOOT_PORT" ] && [ -z "$SMART_SHELL_ANGULAR_PORT" ]; 
then
    echo "The SMART_SHELL_POSTGRES_PORT, SMART_SHELL_REDIS_PORT, SMART_SHELL_MONGO_PORT, SMART_SHELL_SPRINGBOOT_PORT or SMART_SHELL_ANGULAR_PORT variable is not defined in the system environment!" >&2
    exit 1000
fi

# Verify if the network exists
if ! sudo docker network inspect smart-shell-net &>/dev/null; then
    sudo docker network create --driver bridge smart-shell-net
else
    echo "La red 'smart-shell-net' ya existe."
fi

# Create directory deployments and volumes
if [ ! -d "/var/www/smart-shell/deployments" ]; then
    sudo mkdir -p /var/www/smart-shell/deployments
    git config --global --add safe.directory "/var/www/smart-shell/deployments"
fi

if [ ! -d "/var/www/smart-shell/volumes" ]; then
    sudo mkdir -p /var/www/smart-shell/volumes
fi

if [ ! -d "/var/www/smart-shell/backups" ]; then
    sudo mkdir -p /var/www/smart-shell/backups
fi

sudo chown -R $USER:$USER /var/www/smart-shell

# Chmod scripts
sudo chmod +x ./scripts/install/postgres.sh
sudo chmod +x ./scripts/install/redis.sh
sudo chmod +x ./scripts/install/mongo.sh
sudo chmod +x ./scripts/install/java.sh
sudo chmod +x ./scripts/install/angular.sh

sudo chmod +x ./scripts/deploy/postgres.sh
sudo chmod +x ./scripts/deploy/redis.sh
sudo chmod +x ./scripts/deploy/mongo.sh
sudo chmod +x ./scripts/deploy/java.sh
sudo chmod +x ./scripts/deploy/angular.sh

# Execute installation scripts
bash ./scripts/install/postgres.sh &&
bash ./scripts/install/redis.sh &&
bash ./scripts/install/mongo.sh &&
bash ./scripts/install/java.sh &&
bash ./scripts/install/angular.sh