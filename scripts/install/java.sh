#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-springboot no existe
if [ ! -d "smart-shell-springboot" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-springboot.git
    cd smart-shell-springboot
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-springboot
    git pull origin main
fi

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
SMART_SHELL_SPRINGBOOT_PORT=${SMART_SHELL_SPRINGBOOT_PORT}
SMART_SHELL_POSTGRES_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_POSTGRES_PORT=${SMART_SHELL_POSTGRES_PORT}
SMART_SHELL_POSTGRES_DATABASE=smart_shell
SMART_SHELL_POSTGRES_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_POSTGRES_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_MONGO_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_MONGO_PORT=${SMART_SHELL_MONGO_PORT}
SMART_SHELL_MONGO_DATABASE=smart_shell
SMART_SHELL_MONGO_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_MONGO_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_REDIS_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_REDIS_PORT=${SMART_SHELL_REDIS_PORT}
SMART_SHELL_REDIS_USERNAME=default
SMART_SHELL_REDIS_PASSWORD=${DATABASE_PASSWORD}
EOF