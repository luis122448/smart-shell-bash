# Move to /my-project
cd ./my-project

# Verifica si el directorio smart-shell-redis no existe
if [ ! -d "smart-shell-redis" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-redis.git
else
    git pull origin main
fi

# Ejecute script dev-install.sh
cd smart-shell-redis
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
    touch "$ENV_FILE"
fi

# Modify .env file
echo -e "REDIS_PASSWORD=$DATABASE_PASSWORD" > "$ENV_FILE"

# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..