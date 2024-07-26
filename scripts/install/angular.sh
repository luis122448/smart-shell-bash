#!/bin/bash

cd /home/$SERVER_USER/smart-shell

# Verifica si el directorio smart-shell-angular no existe
if [ ! -d "smart-shell-angular" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-angular.git
    cd smart-shell-angular
else
    git config --global --add safe.directory ./smart-shell-angular
    cd smart-shell-angular
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
API_URL=https://smart-shell.luis122448.dev/app-project
API_SUNAT_TOKEN=lCSzUmWQLRZT4ytYL3EgHCKTBh7K2dswFaFjsB1nKkq6RIaGB0AuRD2qvtsxm8q4
EOF

# Deploy container
sudo bash deploy.sh