#!/bin/bash
set -e

cd /var/www/project

# Verifica si el directorio metrics-fastapi no existe
if [ ! -d "metrics-fastapi" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/metrics-fastapi.git
    cd metrics-fastapi
else
    git config --global --add safe.directory ./metrics-fastapi
    cd metrics-fastapi
    git pull origin main
fi

# Ejecute script install.sh
sudo chmod +x install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=${SERVER_LOCAL_HOST}:8080/app-project
EOF

# Stop container
sudo docker stop metrics-fastapi

# Deploy container
sudo bash deploy.sh