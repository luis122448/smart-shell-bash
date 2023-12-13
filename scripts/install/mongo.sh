# Move to /my-project
cd ./my-project

# Verifica si el directorio smart-shell-mongo no existe
if [ ! -d "smart-shell-mongo" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-mongo.git
    cd smart-shell-mongo
else
    git config --global --add safe.directory ./smart-shell-mongo
    cd smart-shell-mongo
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
    echo -e "MONGO_USERNAME=developer\nMONGO_PASSWORD=${DATABASE_PASSWORD}\nMONGO_DATABASE=smart_shell" > "$ENV_FILE"
    echo "Se ha modificado el archivo $ENV_FILE con la contraseña de la base de datos."
else
    echo "La variable DATABASE_PASSWORD no está definida en el entorno del sistema." >&2
    exit 1000
fi

# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..