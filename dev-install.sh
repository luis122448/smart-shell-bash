#
cd ..

# 
cd ..

# Crear directorios y archivos necesarios para el proyecto
mkdir -p /my-project

# Create network
sudo docker network create --driver bridge smart-shell-network

# Ejectute script for postgres and redis
./scripts/postgres.sh
./scripts/redis.sh
