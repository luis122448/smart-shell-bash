# Docs
# https://www.swhosting.com/es/comunidad/manual/como-crear-un-proxy-inverso-con-nginx

# Instalar Nginx en tu VM

```bash
    sudo apt update
    sudo apt install nginx
```

# Revisar la configuración realizada

``` bash
    cat ./scripts/proxy/luis122448.dev.conf
```

# Reubica el archivo de configuración

``` bash
    sudo cp ./scripts/proxy/luis122448.dev.conf /etc/nginx/sites-available/luis122448.dev.conf
    sudo cp ./scripts/proxy/luis122448.com.conf /etc/nginx/sites-available/luis122448.com.conf
```

# Reinicia Nginx

```bash
    systemctl reload nginx
```

# Verificar Estatus de la configuración

```bash
    sudo nginx -t
```