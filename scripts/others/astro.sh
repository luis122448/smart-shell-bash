#!/bin/bash
set -e

cd /var/www/project

# Verifica si el directorio my-landing-page no existe
if [ ! -d "my-landing-page" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/my-landing-page.git
    cd my-landing-page
else
    git config --global --add safe.directory ./my-landing-page
    cd my-landing-page
    git pull origin main
fi

# Ejecute script install.sh
sudo chmod +x install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=${SERVER_LOCAL_HOST}:8080/app-project
EOF

# Stop container
sudo docker stop my-landing-page

# Deploy container
sudo bash deploy.sh