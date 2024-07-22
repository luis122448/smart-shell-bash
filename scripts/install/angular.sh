# Move to /my-project
cd ./my-project

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
POSTGRES_HOST=postgresql:5432
POSTGRES_DATABASE=${DATABASE_NAME}
POSTGRES_USERNAME=${DATABASE_USERNAME}
POSTGRES_PASSWORD=${DATABASE_PASSWORD}
MONGO_HOST=mongo:27017
MONGO_DATABASE=${DATABASE_NAME}
MONGO_USERNAME=${DATABASE_USERNAME}
MONGO_PASSWORD=${DATABASE_PASSWORD}
REDIS_HOST=redis
REDIS_USERNAME=${DATABASE_USERNAME}
REDIS_PASSWORD=${DATABASE_PASSWORD}
EOF


# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..