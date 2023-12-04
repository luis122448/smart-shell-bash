# Move to /my-project
cd /my-project

# Clone repository ( Redis )
git clone https://github.com/luis122448/smart-shell-redis.git

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

# 
cd ..