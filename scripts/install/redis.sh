#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-redis no existe
if [ ! -d "smart-shell-redis" ]; then
    git clone git@github.com:luis122448/smart-shell-redis.git
fi

cd /var/www/smart-shell/deployments/smart-shell-redis
git pull origin main

echo "Installing Smart Shell Redis..."
sudo chmod +x install.sh &&
bash install.sh &&

# Environtment file
cat <<EOF > "/var/www/smart-shell/deployments/smart-shell-redis/.env"
cat <<EOF > "$ENV_FILE"
SMART_SHELL_REDIS_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_REDIS_PORT=${SMART_SHELL_REDIS_PORT}
SMART_SHELL_REDIS_USERNAME=default
SMART_SHELL_REDIS_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_REDIS_DATABASE=smart_shell
EOF