mkdir -p ./my-project

# Verifica si la red ya existe
if ! sudo docker network inspect smart-shell-network &>/dev/null; then
    # Si no existe, crea la red
    sudo docker network create --driver bridge smart-shell-network
else
    echo "La red 'smart-shell-network' ya existe."
fi

# Configurando permisos de ejecucion
sudo chmod +x ./scripts/install/postgres.sh
sudo chmod +x ./scripts/install/redis.sh

# Ejecutando scripts de instalacion
bash `./scripts/postgres.sh`
bash `./scripts/redis.sh`