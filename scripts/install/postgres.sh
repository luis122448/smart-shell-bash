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

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno con las credenciales de PostgreSQL
cat <<EOF > "$ENV_FILE"
POSTGRES_HOST=${SERVER_HOST}
POSTGRES_PORT=5432
POSTGRES_USERNAME=${DATABASE_USERNAME}
POSTGRES_PASSWORD=${DATABASE_PASSWORD}
POSTGRES_DATABASE=${DATABASE_NAME}
EOF

# Deploy container
sudo bash deploy.sh