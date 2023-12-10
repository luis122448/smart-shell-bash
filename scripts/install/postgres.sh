# Move to /my-project
cd ./my-project

# Verifica si el directorio smart-shell-postgres no existe
if [ ! -d "smart-shell-postgres" ]; then
    # Si no existe, clona el repositorio
    git clone https://github.com/luis122448/smart-shell-postgres.git
else
    git pull origin main
fi

# Ejecute script dev-install.sh
cd smart-shell-postgres
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
    touch "$ENV_FILE"
fi

# Modify .env file
echo -e "POSTGRES_USER=postgres\nPOSTGRES_PASSWORD=$DATABASE_PASSWORD\nPOSTGRES_DB=smart-shell" > "$ENV_FILE"

# Deploy container
sudo bash deploy.sh

# Return to /my-project
cd ..