#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-angular no existe
if [ ! -d "smart-shell-angular" ]; then
    git clone git@github.com:luis122448/smart-shell-angular.git
fi

cd /var/www/smart-shell/deployments/smart-shell-angular
git pull origin main

echo "Installing Smart Shell Angular..."
sudo chmod +x install.sh &&
bash install.sh &&

# Environtment file
cat <<EOF > "/var/www/smart-shell/deployments/smart-shell-angular/.env"
cat <<EOF > "$ENV_FILE"
SMART_SHELL_ANGULAR_PORT=${SMART_SHELL_ANGULAR_PORT}
API_URL=http://${SERVER_LOCAL_HOST}:${SMART_SHELL_SPRINGBOOT_PORT}
API_SUNAT_TOKEN=lCSzUmWQLRZT4ytYL3EgHCKTBh7K2dswFaFjsB1nKkq6RIaGB0AuRD2qvtsxm8q4
EOF