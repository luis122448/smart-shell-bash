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

# Ejecute script install.sh
sudo chmod +x install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

cat <<EOF > "$ENV_FILE"
SMART_SHELL_MONGO_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_MONGO_PORT=${SMART_SHELL_MONGO_PORT}
SMART_SHELL_MONGO_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_MONGO_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_MONGO_DATABASE=smart_shell
EOF