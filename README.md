![Logo del Projecto](./resources/logo.png)

# Despliegue Automatizado de Contededores Dockers con Bash Scripts

Este repositorio tiene como objetivo documentar y automatizar el despliegue de tres contenedores de base de datos (PostgreSQL, MongoDB y Redis) para el proyecto de Smart-Shell ( Facturador Electronico ) y Platform-Training ( Plataforma de Capacitacion ) utilizando scripts de Bash que automatizan la instalación de Docker y Docker Compose, la configuración de las variables de entorno, la clonación y despliegue de los repositorios de Base de Datos relacionados.
  
## Repositorios Relacionados

### Repositorio Actual
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Repositorios de Base de Datos Relacionados

Estos repositorios contienen la documentación y los scripts de despliegue de los contenedores de base de datos para el proyecto Smart-Shell y Platform-Training
- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)
PosgresSQL: Es la base de datos transaccional, encargada de guardar la información de los usuarios, roles, permisos, facturas, productos, clientes, etc.
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
MongoDB: Es la base de datos encargada de guardar la informacion binaria ( archivos, imagenes, etc ) y su repectiva informacion de auditoria.
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)
Redis: Es la base de datos utilizada para el cache de la aplicacion.
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
SpringBoot: Es el backend de la aplicacion Smart-Shell, encargado de la logica de negocio y la comunicacion con las bases de datos.
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
Angular: Es el frontend de la aplicacion Smart-Shell, encargado de la interfaz de usuario y la comunicacion con el backend.

### Nomenclatura de los Commit ( Comventional Commits )

Para el control de versiones se ha utilizado la nomenclatura de los commits de acuerdo a la especificación de [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). A continuación se detallan los prefijos utilizados en los commits y su significado:

- **build**: Cambios que afectan el sistema de construcción o dependencias externas (ejemplo: gulp, broccoli, npm).
- **ci**: Cambios en los archivos y scripts de configuración y automatización de CI (ejemplo: Travis, Circle, BrowserStack, SauceLabs).
- **chore**: Otros cambios que no modifican el código fuente ni los archivos de prueba.
- **docs**: Cambios en la documentación.
- **feat**: Una nueva funcionalidad.
- **fix**: Una corrección de errores.
- **perf**: Un cambio de código que mejora el rendimiento.
- **refactor**: Un cambio de código que no corrige un error ni agrega una función.
- **revert**: Revierte un commit anterior.
- **style**: Cambios que no afectan el significado del código (espacios en blanco, formato, punto y coma que faltan, etc.).
- **test**: Agregar pruebas faltantes o corregir pruebas existentes.

Adempàs, se puede definir opcionalmente un alcance para el commit, el cual puede ser cualquier cosa que especifique el lugar del cambio. Por ejemplo, auth, user, etc.

A continuación se muestra un ejemplo de un mensaje de confirmación que sigue la especificación de confirmaciones convencionales:

    ```bash
        feat(auth): allow provided config object to extend other configs
    ```
    
    ```bash
        fix(user): ensure bucket key does not have leading slash
    ```

## Inicilizando repositorio

1. **Clonar el Repositorio**
   
    ```bash
        git clone https://github.com/luis122448/smart-shell-bash.git
    ```

2. **Ingresar al directorio del proyecto**
        
    ```bash
        cd smart-shell-bash
    ```

3. **Ejecutar el script de instalación**
    
    ```bash
        sudo bash dev-install.sh
    ```

4. **Definir las variables de entorno**
    
    Edita el archivo /etc/environment con privilegios de administrador.
    
    ```bash
        sudo nano /etc/environment
    ```
    
    Defina las siguientes variables del sistema.
    
    ```bash
        SMART_SHELL_DOMAIN_BACKEND=""
        SMART_SHELL_DOMAIN_FRONTEND=""
        SERVER_HOST=""
        DATABASE_NAME=""
        DATABASE_USERNAME=""
        DATABASE_PASSWORD=""
    ```
    Guarda los cambios y cierra el editor.

    Nota: El password definido en la variable *DATABASE_PASSWORD* será utilizado para la configuración de todas las bases de datos.
    
## Despliegue en Producción

Para el despliegue en producción se ha utilizado Docker y Docker Compose, puede revisar el archivo docker-compose.yml para conocer los detalles de la configuración.

1. **Ejecutar el script de despliegue**
    
    ```bash
        sudo bash deploy.sh
    ```

## Verificacion del despliegue

1. **Verificar archivos del projecto:**
    Verificar la exportacion del codigo de los projectos, en el directorio smart-shell

    ```bash
        smart-shell-bash/
        ├── smart-shell/
        │   ├── smart-shell-postgres
        │   ├── smart-shell-redis
        │   ├── smart-shell-mongo
        │   └── ...
        └── ...
    ```

2.  **Verficiar el despliege de los contenedores**
    
    ```bash
        sudo docker ps
    ```
    
3. **Realizar los test de conexion, siguiendo la documentacion ( README.md ) de cada de unos de los projectos**

    ```bash
        sudo cat smart-shell/smart-shell-postgres/README.md
        sudo cat smart-shell/smart-shell-redis/README.md
        sudo cat smart-shell/smart-shell-mongo/README.md
    ```

## Contribuciones
Las contribuciones son bienvenidas. Siéntete libre de mejorar este proyecto, agregar nuevas características o corregir problemas identificados. Para contribuir, crea un Pull Request o abre un Issue.

## Licencia
Este proyecto está bajo la licencia MIT License.