#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-postgres no existe
if [ ! -d "smart-shell-postgres" ]; then
    git clone git@github.com:luis122448/smart-shell-postgres.git
fi

cd /var/www/smart-shell/deployments/smart-shell-postgres
git pull origin main

echo "Installing Smart Shell Postgres..."
sudo chmod +x install.sh &&
bash install.sh &&

# Environtment file
cat <<EOF > "/var/www/smart-shell/deployments/smart-shell-postgres/.env"
SMART_SHELL_POSTGRES_HOST=${SERVER_LOCAL_HOST}
SMART_SHELL_POSTGRES_PORT=${SMART_SHELL_POSTGRES_PORT}
SMART_SHELL_POSTGRES_USERNAME=${DATABASE_USERNAME}
SMART_SHELL_POSTGRES_PASSWORD=${DATABASE_PASSWORD}
SMART_SHELL_POSTGRES_DATABASE=smart_shell
EOF