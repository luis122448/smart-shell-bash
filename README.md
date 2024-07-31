![Logo del Projecto](./resources/logo.png)

# Despliegue Automatizado de Contededores Dockers con Bash Scripts

Este repositorio tiene como objetivo documentar, estandarizar y automatizar el despliegue del proyecto Smart-Shell ( Facturador Electronico ), integrado por cinco repositorios independientes en un mismo servidor.

La automatizacion incluye la configuracion de las variables entorno, clonacion de repositorios, generacion de certificados SSL, configuracion del servidor Nginx ( Proxy Inverso ) y finalmente el desarrollo/despliege continuo.
  
## Repositorios

### Repositorio Actual
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Repositorios Relacionados

- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)
PosgresSQL: Base de datos transaccional.
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
MongoDB: Almacena información binaria (archivos, imágenes), metadata y auditoria.
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)
Redis: Base de datos de caching.
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
SpringBoot: BackEnd para la logica de negocio y reporteria.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
Angular: FrontEnd para la interfaz de usuario.

## Nomenclatura de los Commit ( Comventional Commits )

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
- **deploy**: Cambios referidos al despliege de la aplicacion

Adempàs, se puede definir opcionalmente un alcance para el commit, el cual puede ser cualquier cosa que especifique el lugar del cambio. Por ejemplo, auth, user, etc.

A continuación se muestra un ejemplo de un mensaje de confirmación que sigue la especificación de confirmaciones convencionales:

    ```bash
        feat(auth): allow provided config object to extend other configs
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

3. **Definir las variables de entorno**
    
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

4. **Generar los certificados SSH y configurar el servidor NGINX**

    Revisar el archivo ./scripts/ssh/README.md para generar los certificados SSH segun el dominio a utilizar para el Back y Front.
    Adicionalmente revisar la instrucciones en ./scripts/proxy/README.md para la configuracion del servidor de NGINX.

    ```bash
        smart-shell-bash/
        ├── scripts/
        │   ├── ssh/
        │   │   ├── README.md
        │   │   └── ...
        │   ├── proxy/
        │   │   ├── luis122448.com.conf ( Front )
        │   │   ├── luis122448.dev.conf ( Back )
        │   │   ├── options-ssl-nginx.conf
        │   │   ├── README.md
        │   │   └── ...
        │   └── ...
        └── ...
    ```

5. **Ejecutar el script de instalación y despliege**
    
    ```bash
        sudo bash dev-install.sh
    ```

## Desarrollo y despliege continuo

Para el despliege de toda la aplicacion se debe ejecutar el scrip deploy.sh.

1. **Ejecutar el script de despliegue**
    
    ```bash
        sudo bash deploy.sh
    ```

Para desplieges especficicos de cada repositorio revisar los scriptS en ./scripts/deploy/... 

## Verificacion del despliegue

1. **Verificar archivos del projecto:**
    Verificar la clonacion de los repositorios, en el directorio $SERVER_HOST

    ```bash
        $SERVER_HOST/
        ├── smart-shell/
        │   ├── smart-shell-postgres
        │   ├── smart-shell-redis
        │   ├── smart-shell-mongo
        │   ├── smart-shell-springboot
        │   ├── smart-shell-angular
        │   └── ...
        └── ...
    ```

2.  **Verficiar el despliege de los contenedores**
    
    ```bash
        sudo docker ps
    ```
    
3. **Realizar los test de conexion, siguiendo la documentacion ( README.md ) de cada de uno de los proyectos**

    ```bash
        sudo cat smart-shell/smart-shell-postgres/README.md
        sudo cat smart-shell/smart-shell-redis/README.md
        sudo cat smart-shell/smart-shell-mongo/README.md
        sudo cat smart-shell/smart-shell-springboot/README.md
        sudo cat smart-shell/smart-shell-angular/README.md
    ```

## Contribuciones
Las contribuciones son bienvenidas. Siéntete libre de mejorar este proyecto, agregar nuevas características o corregir problemas identificados. Para contribuir, crea un Pull Request o abre un Issue.

## Licencia
Este proyecto está bajo la licencia MIT License.