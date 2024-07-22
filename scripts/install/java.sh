# Move to /my-project
cd ./my-project

# Verifica si el directorio smart-shell-springboot no existe
if [ ! -d "smart-shell-springboot" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-springboot.git
    cd smart-shell-springboot
else
    git config --global --add safe.directory ./smart-shell-springboot
    cd smart-shell-springboot
    git pull origin main
fi

# Ejecute script dev-install.sh
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
: > "$ENV_FILE"

# Crea o sobrescribe el archivo de entorno para la conexión a la base de datos
cat <<EOF > "$ENV_FILE"
POSTGRES_HOST=localhost:5432
POSTGRES_DATABASE=${DATABASE_NAME}
POSTGRES_USERNAME=${DATABASE_USERNAME}
POSTGRES_PASSWORD=${DATABASE_PASSWORD}
MONGO_HOST=localhost:27017
MONGO_DATABASE=${DATABASE_NAME}
MONGO_USERNAME=${DATABASE_USERNAME}
MONGO_PASSWORD=${DATABASE_PASSWORD}
REDIS_HOST=localhost
REDIS_USERNAME=${DATABASE_USERNAME}
REDIS_PASSWORD=${DATABASE_PASSWORD}
EOF


# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..