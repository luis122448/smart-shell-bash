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
if [ ! -f "$ENV_FILE" ]; then
    touch "$ENV_FILE"
fi

# Comprueba si la variable está definida
if [ -n "$DATABASE_PASSWORD" ]; then
    echo -e "REDIS_PASSWORD=$DATABASE_PASSWORD" > "$ENV_FILE"
    echo "Se ha modificado el archivo $ENV_FILE con la contraseña de la base de datos."
else
    echo "La variable DATABASE_PASSWORD no está definida en el entorno del sistema." >&2
    exit 1000
fi

# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..