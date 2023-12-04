# Move to /my-project
cd /my-project

# Clone repository ( Postgres )
git clone https://github.com/luis122448/smart-shell-postgres.git

# Ejecute script dev-install.sh
cd smart-shell-postgres
sudo chmod +x dev-install.sh

# Edit .env file
ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
    touch "$ENV_FILE"
fi

# Modify .env file
echo -e "POSTGRES_USER=postgres\nPOSTGRES_PASSWORD=$$DATABASE_PASSWORD\nPOSTGRES_DB=smart-shell" > "$ENV_FILE"

# Deploy container
sudo bash deploy.sh

# 
cd ..