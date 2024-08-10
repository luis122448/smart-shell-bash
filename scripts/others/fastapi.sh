#!/bin/bash

cd /home/$SERVER_USER/project

# Verifica si el directorio metrics-fastapi no existe
if [ ! -d "metrics-fastapi" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/metrics-fastapi.git
    cd metrics-fastapi
else
    git config --global --add safe.directory ./metrics-fastapi
    cd metrics-fastapi
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=${SERVER_HOST}:8080/app-project
EOF

# Stop container
sudo docker stop metrics-fastapi

# Deploy container
sudo bash deploy.sh