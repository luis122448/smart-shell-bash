#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-angular no existe
if [ ! -d "smart-shell-angular" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-angular.git
    cd smart-shell-angular
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-angular
    git pull origin main
fi

echo "Installing Smart Shell Angular..."
sudo chmod +x install.sh
bash install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
SMART_SHELL_ANGULAR_PORT=${SMART_SHELL_ANGULAR_PORT}
API_URL=http://${SERVER_LOCAL_HOST}:${SMART_SHELL_SPRINGBOOT_PORT}
API_SUNAT_TOKEN=lCSzUmWQLRZT4ytYL3EgHCKTBh7K2dswFaFjsB1nKkq6RIaGB0AuRD2qvtsxm8q4
EOF