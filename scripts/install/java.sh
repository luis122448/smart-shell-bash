#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-springboot no existe
if [ ! -d "smart-shell-springboot" ]; then
    git clone git@github.com:luis122448/smart-shell-springboot.git
fi

cd /var/www/smart-shell/deployments/smart-shell-springboot
git pull origin main

echo "Installing Smart Shell Springboot..."
sudo chmod +x install.sh &&
bash install.sh &&

# Environtment file
cat <<EOF > "/var/www/smart-shell/deployments/smart-shell-springboot/.env"
SMART_SHELL_SPRINGBOOT_PORT=${SMART_SHELL_SPRINGBOOT_PORT}
SMART_SHELL_POSTGRES_HOST=smart-shell-postgres
SMART_SHELL_POSTGRES_PORT_INTERNAL=5432
SMART_SHELL_POSTGRES_DATABASE=smart_shell
SMART_SHELL_POSTGRES_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_POSTGRES_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_MONGO_HOST=smart-shell-mongo
SMART_SHELL_MONGO_PORT_INTERNAL=27017
SMART_SHELL_MONGO_DATABASE=smart_shell
SMART_SHELL_MONGO_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_MONGO_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_REDIS_HOST=smart-shell-redis
SMART_SHELL_REDIS_PORT_INTERNAL=6379
SMART_SHELL_REDIS_USERNAME=default
SMART_SHELL_REDIS_PASSWORD=${DATABASE_PASSWORD}
CORS_ALLOWED_ORIGINS=http://localhost:*,http://smart-shell-angular:*
EOF