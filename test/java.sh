#!/bin/bash
set -e

cd /var/www/smart-shell/deployments

# Verifica si el directorio smart-shell-springboot no existe
if [ ! -d "smart-shell-springboot" ]; then
    # Si no existe, clona el repositorio
    git clone git@github.com:luis122448/smart-shell-springboot.git
    cd smart-shell-springboot
else
    git config --global --add safe.directory "$(pwd)"
    cd smart-shell-springboot
    git pull origin main
fi

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Variable
KEYSTORE_DIR="/etc/letsencrypt/live/${SMART_SHELL_DOMAIN_BACKEND}"
KEYSTORE_FILE="/etc/letsencrypt/live/${SMART_SHELL_DOMAIN_BACKEND}/keystore.p12"
KEYSTORE_PASSWORD=${DATABASE_PASSWORD}
KEYSTORE_DOMAIN="smart-shell.luis122448.com"

# Validar la existencia del directorio
if [ ! -d "$KEYSTORE_DIR" ]; then
    echo "Error: El directorio $KEYSTORE_DIR no existe."
    exit 1
fi

# Validar la existencia de los archivos necesarios
FULLCHAIN_FILE="$KEYSTORE_DIR/fullchain.pem"
PRIVKEY_FILE="$KEYSTORE_DIR/privkey.pem"

if [ ! -f "$FULLCHAIN_FILE" ]; then
    echo "Error: El archivo $FULLCHAIN_FILE no existe."
    exit 1
fi

if [ ! -f "$PRIVKEY_FILE" ]; then
    echo "Error: El archivo $PRIVKEY_FILE no existe."
    exit 1
fi

# Create keystore PKCS12
openssl pkcs12 -export -in "$FULLCHAIN_FILE" -inkey "$PRIVKEY_FILE" -out "$KEYSTORE_FILE" -name "$KEYSTORE_DOMAIN" -passout pass:"$KEYSTORE_PASSWORD"

if [ $? -ne 0 ]; then
    echo "Error al crear el archivo PKCS12."
    exit 1
fi

# Copy
sudo chmod 600 "$KEYSTORE_FILE"
sudo chown developer-user "$KEYSTORE_FILE"
mkdir ./resources/key
sudo cp "$KEYSTORE_FILE" ./resources/key/keystore.p12

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
POSTGRES_HOST=${SERVER_LOCAL_HOST}
POSTGRES_PORT=5432
POSTGRES_DATABASE=${DATABASE_NAME}
POSTGRES_USERNAME=${DATABASE_USERNAME}
POSTGRES_PASSWORD=${DATABASE_PASSWORD}
MONGO_HOST=${SERVER_LOCAL_HOST}
MONGO_PORT=27017
MONGO_DATABASE=${DATABASE_NAME}
MONGO_USERNAME=${DATABASE_USERNAME}
MONGO_PASSWORD=${DATABASE_PASSWORD}
REDIS_HOST=${SERVER_LOCAL_HOST}
REDIS_PORT=6379
REDIS_USERNAME=default
REDIS_PASSWORD=${DATABASE_PASSWORD}
KEYSTORE_FILE=/usr/local/key/keystore.p12
KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD
KEYSTORE_DOMAIN=$KEYSTORE_DOMAIN
EOF

# Deploy container
sudo bash deploy.sh