#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-mongo no existe
if [ ! -d "smart-shell-mongo" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-mongo.git
    cd smart-shell-mongo
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-mongo
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

cat <<EOF > "$ENV_FILE"
MONGO_HOST=${SERVER_HOST}
MONGO_PORT=27017
MONGO_USERNAME=${DATABASE_USERNAME}
MONGO_PASSWORD=${DATABASE_PASSWORD}
MONGO_DATABASE=${DATABASE_NAME}
EOF

# Deploy container
sudo bash deploy.sh