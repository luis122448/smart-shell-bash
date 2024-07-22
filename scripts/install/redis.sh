# Move to /my-project
cd ./my-project

# Verifica si el directorio smart-shell-redis no existe
if [ ! -d "smart-shell-redis" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-redis.git
    cd smart-shell-redis
else
    git config --global --add safe.directory ./smart-shell-redis
    cd smart-shell-redis
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno con las credenciales de Redis
cat <<EOF > "$ENV_FILE"
REDIS_USERNAME=${DATABASE_USERNAME}
REDIS_PASSWORD=${DATABASE_PASSWORD}
REDIS_DATABASE=${DATABASE_NAME}
EOF

# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..