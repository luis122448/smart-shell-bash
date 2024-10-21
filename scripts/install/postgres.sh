#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-postgres no existe
if [ ! -d "smart-shell-postgres" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-postgres.git
    cd smart-shell-postgres
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-postgres
    git pull origin main
fi

# Ejecute script install.sh
sudo chmod +x install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno con las credenciales de PostgreSQL
cat <<EOF > "$ENV_FILE"
SMART_SHELL_POSTGRES_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_POSTGRES_PORT=${SMART_SHELL_POSTGRES_PORT}
SMART_SHELL_POSTGRES_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_POSTGRES_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_POSTGRES_DATABASE=smart_shell
EOF