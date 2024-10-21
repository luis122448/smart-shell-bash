![Logo del Projecto](./resources/logo.png)

# Deploying Docker Containers with Bash Scripts

Its repository contains the scripts necessary to automate the deployment of the Smart-Shell project, which is integrated by five independent repositories in the same server.

The automation includes the configuration of the environment variables, cloning of repositories, generation of SSL certificates, configuration of the Nginx server (Reverse Proxy) and finally the continuous development/deployment.
  
## Repositorys

### Principal Repository
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Relational Repositorys

- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)
PosgresSQL: Database for the storage of structured data.
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
MongoDB: Database for the storage of non-structured data.
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)
Redis: Database for the storage of key-value data.
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
SpringBoot: BackEnd for the business logic.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
Angular: FrontEnd for the user interface.

## Installation

1. **Create a new directory**

    ```bash
        sudo mkdir /var/www/smart-shell

        sudo mkdir /var/www/smart-shell/configurations
    ```

2. **Change the owner of the directory**
   
    ```bash
        sudo chown -R $USER:$USER /var/www/smart-shell
    ```

3. **Clone the repository**
   
    ```bash
        cd /var/www/smart-shell/configurations

        git clone git@github.com:luis122448/smart-shell-bash.git
        git clone https://github.com/luis122448/smart-shell-bash.git
    ```

4. **Define the environment variables**
    
    First, define the IP address of the server for $SERVER_LOCAL_HOST variable:
    
    ```bash
        ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+' 
    ```

    Update the file "enviroment.sh" with the following variables:

    ```bash
        #!/bin/bash
        export SERVER_LOCAL_HOST=
        export SERVER_LOCAL_USER=
        export DATABASE_USERNAME=
        export DATABASE_PASSWORD=

        # Ports
        export SMART_SHELL_POSTGRES_PORT=10001
        export SMART_SHELL_REDIS_PORT=10002
        export SMART_SHELL_MONGO_PORT=10003
        export SMART_SHELL_SPRINGBOOT_PORT=10004
        export SMART_SHELL_ANGULAR_PORT=10005
    ```

    Charge the environment variables:

    ```bash
        source environment.sh
    ```

    **Nota:** The password defined in the *DATABASE_PASSWORD* variable will be used for the configuration of all databases.

5. **Execute the installation script**
    
    ```bash
        bash install.sh
    ```

6. **Verify the installation**
    
    ```bash
        tree /var/www/smart-shell/deployments

        /var/www/smart-shell/deployments
        ├── smart-shell-postgres
        ├── smart-shell-redis
        ├── smart-shell-mongo
        ├── smart-shell-springboot
        ├── smart-shell-angular
        └── ...
    ```

## Local Development

1. **Execute the deployment script**
    
    ```bash
        bash deploy.sh
    ```

2. **Verify the deployment**
    
    ```bash
        sudo docker ps
    ```

## Production Deployment

1. **Generate the SSH certificates and configure the NGINX server**

    Review the file ./scripts/ssh/README.md to generate the SSH certificates according to the domain to be used for the Back and Front.
    Additionally, review the instructions in ./scripts/proxy/README.md for the configuration of the NGINX server.

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

## Contributing

All contributions are welcome. For more information, please refer to the [CONTRIBUTING](./CONTRIBUTING.md) file.

## License

Its project is licensed under the terms of the [Creative Commons Attribution-NonCommercial 4.0 License](./LICENSE).