#!/bin/bash

# Verifica la configuración del Host
if [ -z "$SERVER_HOST" ] && [ -z "$SERVER_USER" ]; 
then
    echo "The SERVER_HOST or SERVER_USER variable is not defined in the sustem environment!" >&2
    exit 1000
fi

# Verifica si la variable no está definida
if [ -z "$DATABASE_PASSWORD" ] && [ -z "$DATABASE_USERNAME" ] && [ -z "$DATABASE_NAME" ]; 
then
    echo "The DATABASE USERNAME, DATABASE_NAME, or DATABASE_PASSWORD variable is not defined in the system environment!" >&2
    exit 1000
fi

DIRECTORY="/var/www/smart-shell/deployments"

# Verifica si el directorio existe
if [ -d "$DIRECTORY" ]; 
then
    rm -rf "$DIRECTORY"/*
    echo "El contenido del directorio '$DIRECTORY' ha sido eliminado."
else
    mkdir -p "$DIRECTORY"
    echo "El directorio '$DIRECTORY' se ha creado."
fi

# Verifica si la red ya existe
if ! sudo docker network inspect smart-shell-net &>/dev/null; then
    # Si no existe, crea la red
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

# Habilita permisos de ejecución
sudo chmod +x ./scripts/install/postgres.sh
sudo chmod +x ./scripts/install/redis.sh
sudo chmod +x ./scripts/install/mongo.sh
sudo chmod +x ./scripts/install/java.sh
sudo chmod +x ./scripts/install/angular.sh

sudo bash `./scripts/install/postgres.sh`
sudo bash `./scripts/install/redis.sh`
sudo bash `./scripts/install/mongo.sh`
sudo bash `./scripts/install/java.sh`
sudo bash `./scripts/install/angular.sh`