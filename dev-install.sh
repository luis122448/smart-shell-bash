DIRECTORY="./my-project"

# Verifica si el directorio existe
if [ -d "$DIRECTORY" ]; then
    # Elimina todo el contenido del directorio si existe
    rm -rf "$DIRECTORY"/*
    echo "El contenido del directorio '$DIRECTORY' ha sido eliminado."
else
    mkdir -p "$DIRECTORY"
    echo "El directorio '$DIRECTORY' se ha creado."
fi

# Verifica si la red ya existe
if ! sudo docker network inspect smart-shell-net &>/dev/null; then
    # Si no existe, crea la red
    sudo docker network create --driver bridge smart-shell-net
else
    echo "La red 'smart-shell-net' ya existe."
fi

# Verifica si la variable no está definida
if [ -z "$DATABASE_PASSWORD" ] && [ -z "$DATABASE_USERNAME" ] && [ -z "$DATABASE_NAME" ]; then
    # La variable DATABASE_PASSWORD no está definida en el entorno del sistema
    echo "La variable DATABASE_USERNAME, DATABASE_NAME o DATABASE_PASSWORD no está definida en el entorno del sistema." >&2
    exit 1000
fi

# Habilita permisos de ejecución
sudo chmod +x ./scripts/install/postgres.sh
sudo chmod +x ./scripts/install/redis.sh
sudo chmod +x ./scripts/install/mongo.sh
sudo chmod +x ./scripts/install/java.sh

# Ejecutando scripts de instalacion
sudo bash `./scripts/install/postgres.sh`
sudo bash `./scripts/install/redis.sh`
sudo bash `./scripts/install/mongo.sh`
sudo bash `./scripts/install/java.sh`