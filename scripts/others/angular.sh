#!/bin/bash

cd /home/$SERVER_USER/project

# Verifica si el directorio dota-shuffle no existe
if [ ! -d "dota-shuffle" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/dota-shuffle.git
    cd dota-shuffle
else
    git config --global --add safe.directory ./dota-shuffle
    cd dota-shuffle
    git pull origin developer
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=https://metrics.luis122448.dev
WS_URL=wss://metrics.luis122448.dev
EOF

# Stop container
sudo docker stop dota-shuffle

# Deploy container
sudo bash deploy.sh