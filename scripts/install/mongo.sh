#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-mongo no existe
if [ ! -d "smart-shell-mongo" ]; then
    git clone git@github.com:luis122448/smart-shell-mongo.git
fi

cd /var/www/smart-shell/deployments/smart-shell-mongo
git pull origin main

echo "Installing Smart Shell Mongo..."
sudo chmod +x install.sh &&
bash install.sh &&

# Environtment file
cat <<EOF > "/var/www/smart-shell/deployments/smart-shell-mongo/.env"
SMART_SHELL_MONGO_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_MONGO_PORT=${SMART_SHELL_MONGO_PORT}
SMART_SHELL_MONGO_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_MONGO_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_MONGO_DATABASE=smart_shell
EOF