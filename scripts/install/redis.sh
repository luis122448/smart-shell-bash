#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-redis no existe
if [ ! -d "smart-shell-redis" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-redis.git
    cd smart-shell-redis
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-redis
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno con las credenciales de Redis
cat <<EOF > "$ENV_FILE"
SMART_SHELL_REDIS_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_REDIS_PORT=${SMART_SHELL_REDIS_PORT}
SMART_SHELL_REDIS_USERNAME=default
SMART_SHELL_REDIS_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_REDIS_DATABASE=smart_shell
EOF