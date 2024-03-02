![Logo del Projecto](./resources/logo.png)

# Despliegue Automatizado de Contededores Dockers con Bash Scripts

Este repositorio tiene como objetivo documentar y automatizar el despliegue de tres contenedores de base de datos (PostgresSQL, MongoDB y Redis) para el proyecto de Smart-Shell ( Facturador Electronico ) y Platform-Training ( Plataforma de Capacitacion ) utilizando scripts de Bash que automatizan la instalación de Docker y Docker Compose, la configuración de las variables de entorno, la clonación y despliegue de los repositorios de Base de Datos relacionados.
  
## Repositorios Relacionados

### Repositorio Actual
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Repositorios de Base de Datos Relacionados

Estos repositorios contienen la documentación y los scripts de despliegue de los contenedores de base de datos para el proyecto Smart-Shell y Platform-Training
- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)

### Repositorios Relacionados ( No incluidos en el despliegue )

Repositorios referidos al BACKEND y FRONTEND de la aplicacion Smart-Shell y Platform-Training.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
- [Platform-Training-Angular](https://github.com/luis122448/platform-training-angular)
- [Platform-Training-SpringBoot](https://github.com/luis122448/platform-training-springboot)

## Inicilizando repositorio

1. **Clonar el Repositorio:**
    ```bash
        git clone https://github.com/luis122448/smart-shell-bash.git
    ```

2. **Ingresar al directorio del proyecto:**
        
    ```bash
        cd smart-shell-bash
    ```

3. **Ejecutar el script de instalación:**
    
    ```bash
        sudo bash dev-install.sh
    ```

4. **Definir las variables de entorno:**
    
    Edita el archivo /etc/environment con privilegios de administrador. Por ejemplo, usando sudo y un editor de texto como nano o vim:
    ```bash
        sudo nano /etc/environment
    ```
    Agrega una línea en el formato DATABASE_PASSWORD="" al final del archivo. Por ejemplo:
    ```bash
        DATABASE_PASSWORD=""
    ```
    Guarda los cambios y cierra el editor.
    
## Despliegue en Producción

Para el despliegue en producción se ha utilizado Docker y Docker Compose, puede revisar el archivo docker-compose.yml para conocer los detalles de la configuración.

1. **Ejecutar el script de despliegue**
    
    ```bash
        sudo bash deploy.sh
    ```

## Verificacion del despliegue

1. **Verificar archivos del projecto:**
    Verificar la exportacion del codigo de los projectos, en el directorio my-project

    ```bash
        smart-shell-bash/
        ├── my-project/
        │   ├── smart-shell-postgres
        │   ├── smart-shell-redis
        │   ├── smart-shell-mongo
        │   └── ...
        └── ...
    ```

2.  **Verficiar el despliege de los contenedores:**
    
    ```bash
        sudo docker ps
    ```
    
3. **Realizar los test de conexion, siguiendo la documentacion ( README.md ) de cada de unos de los projectos**

    ```bash
        sudo cat my-project/smart-shell-postgres/README.md
        sudo cat my-project/smart-shell-redis/README.md
        sudo cat my-project/smart-shell-mongo/README.md
    ```

## Contribuciones
Las contribuciones son bienvenidas. Siéntete libre de mejorar este proyecto, agregar nuevas características o corregir problemas identificados. Para contribuir, crea un Pull Request o abre un Issue.

## Licencia
Este proyecto está bajo la licencia MIT License.