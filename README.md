![Project Logo](./resources/logo.png)

# Smart Shell - Bash Scripts for Docker Deployment

This repository contains the necessary scripts to automate the deployment of the Smart-Shell project, which is composed of five independent repositories, on a single server.

The automation includes the configuration of environment variables, cloning of repositories, generation of SSL certificates, configuration of the Nginx server (Reverse Proxy), and finally, continuous development/deployment.

## Repositories

### Main Repository
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

### Related Repositories

- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)
  PostgreSQL: Database for storing structured data.
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
  MongoDB: Database for storing unstructured data.
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)
  Redis: Database for storing key-value data.
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
  SpringBoot: Backend for the business logic.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
  Angular: Frontend for the user interface.

## Development Environment Setup

This describes the setup for a local development environment, where each service runs in its own Docker container.

### Installation

1.  **Create a new directory**

```bash
sudo mkdir -p /var/www/smart-shell/configurations
```

2.  **Change the owner of the directory**

```bash
sudo chown -R $USER:$USER /var/www/smart-shell
```

3.  **Clone the repository**

```bash
cd /var/www/smart-shell/configurations
git clone https://github.com/luis122448/smart-shell-bash.git
cd smart-shell-bash
```

4.  **Define the environment variables**

First, define the server's IP address for the `$SERVER_LOCAL_HOST` variable. You can get the Docker bridge IP with:

```bash
ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+'
```

Then, define the environment variables in `/etc/environment`:

```bash
sudo nano /etc/environment
```

Add the following variables:
```bash
DATABASE_USERNAME=<your_username>
DATABASE_PASSWORD=<your_password>
SMART_SHELL_POSTGRES_PORT=10001
SMART_SHELL_REDIS_PORT=10002
SMART_SHELL_MONGO_PORT=10003
SMART_SHELL_SPRINGBOOT_PORT=10004
SMART_SHELL_ANGULAR_PORT=10005
```

Load the environment variables:

```bash
source /etc/environment
```

**Note:** The password defined in the `DATABASE_PASSWORD` variable will be used for the configuration of all databases.

5.  **Execute the installation script**

```bash
bash install.sh
```

6.  **Verify the installation**

This will clone all the related project repositories into the `deployments` directory.

```bash
tree /var/www/smart-shell/deployments
```

### Local Development Workflow

1.  **Execute the deployment script**

This script builds and starts the Docker containers for each service.

```bash
bash deploy.sh
```

2.  **Verify the deployment**

```bash
sudo docker ps
```

## Deployment Options

This project offers two main ways to deploy the application stack for production or staging environments: Docker Compose and Kubernetes.

### Docker Compose Deployment

The `docker/` directory contains the necessary files to deploy the entire application stack using Docker Compose. This is a straightforward method for single-server deployments.

1.  **Navigate to the docker directory:**

```bash
cd docker
```

2.  **Configure Environment Variables:**

The configuration is managed via a `.env` file. You should use the provided `backup.env` as a starting point.

```bash
# 1. Copy the backup file to a new .env file
cp backup.env .env

# 2. Open the .env file and customize it
nano .env
```

Inside the `.env` file, you must set the passwords for the databases and can customize ports, domains for CORS, and other parameters.

3.  **Deploy:**

Use the `deploy.sh` script within the `docker` directory to manage the deployment.

```bash
bash deploy.sh
```

This script will handle the creation of necessary directories and start the services defined in `docker-compose.yml`.

### Kubernetes Deployment

For scalable and resilient deployments, you can use the Kubernetes manifests located in the `kubernetes/` directory.

1.  **Navigate to the kubernetes directory:**

```bash
cd kubernetes
```

2.  **Configure the Deployment:**

-   **Domains:** Open the `configmap.yml` file to configure the `INGRESS_HOST` (your domain) and other service-related URLs like `CORS_ALLOWED_ORIGINS`.
-   **Passwords:** The database passwords are not set here. They will be passed securely as a parameter to the deployment script.

3.  **Run the Deployment Script:**

A convenience script, `deploy.sh`, is provided to apply all the manifests in the correct order. You must provide a password for the databases using the `-p` flag.

```bash
bash deploy.sh -p <your-database-password>
```

This script will:
- Create the namespace `smart-shell-production`.
- Create a secret with the provided database password.
- Apply the ConfigMap with your domain configuration.
- Deploy all databases and applications.
- Dynamically configure and apply the Ingress resource based on the settings in the `configmap.yml`.

## Production SSL and Nginx Configuration

For production deployments that are not on Kubernetes, you may need to configure Nginx as a reverse proxy with SSL.

Review the `README.md` file in `./scripts/ssh/` to generate SSL certificates for your domain. Additionally, review the instructions in `./scripts/proxy/README.md` for configuring Nginx.

```
smart-shell-bash/
├── scripts/
│   ├── ssh/
│   │   ├── README.md
│   │   └── ...
│   ├── proxy/
│   │   ├── luis122448.com.conf (Example for Frontend)
│   │   ├── luis122448.dev.conf (Example for Backend)
│   │   ├── options-ssl-nginx.conf
│   │   ├── README.md
│   │   └── ...
│   └── ...
└── ...
```

## Contributing

All contributions are welcome. For more information, please refer to the [CONTRIBUTING](./CONTRIBUTING.md) file.

## License

This project is licensed under the terms of the [Creative Commons Attribution-NonCommercial 4.0 License](./LICENSE).
