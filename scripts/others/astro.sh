#!/bin/bash

cd /home/$SERVER_USER/project

# Verifica si el directorio my-landing-page no existe
if [ ! -d "my-landing-page" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/my-landing-page.git
    cd my-landing-page
else
    git config --global --add safe.directory ./my-landing-page
    cd my-landing-page
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=${SERVER_HOST}:8080/app-project
API_SUNAT_TOKEN=lCSzUmWQLRZT4ytYL3EgHCKTBh7K2dswFaFjsB1nKkq6RIaGB0AuRD2qvtsxm8q4
EOF

# Deploy container
sudo bash deploy.sh