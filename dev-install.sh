# Moverse a la carpeta raiz de la aplicacion
cd ./

# Crear directorios y archivos necesarios para el proyecto
mkdir -p /my-project

# Verifica si la red ya existe
if ! sudo docker network inspect smart-shell-network &>/dev/null; then
    # Si no existe, crea la red
    sudo docker network create --driver bridge smart-shell-network
else
    echo "La red 'smart-shell-network' ya existe."
fi

# PATH de la ubicacion del script
SCRIPT_PATH="/my-script"

# Ejecutando scripts de instalacion
$SCRIPT_PATH/smart-shell-bash/scripts/postgres.sh
$SCRIPT_PATH/smart-shell-bash/scripts/redis.sh