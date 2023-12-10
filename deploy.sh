# Configurando permisos de ejecucion
sudo chmod +x ./scripts/deploy/postgres.sh
sudo chmod +x ./scripts/deploy/redis.sh

# Ejecutando scripts de instalacion
bash `./scripts/deploy/postgres.sh`
bash `./scripts/deploy/redis.sh`