# Docs
# https://www.swhosting.com/es/comunidad/manual/como-crear-un-proxy-inverso-con-nginx

# Revisar si el dominio configurado apunta a la IP del servidor

```bash
    dig luis122448.dev
    dig luis122448.com
```

# Instalar Nginx en tu VM

```bash
    sudo apt update
    sudo apt install nginx
```

# Revisar la configuración del proxy inverso

``` bash
    cat ./scripts/proxy/luis122448.com.conf
    cat ./scripts/proxy/luis122448.dev.conf
```

# Reubica el archivo de configuración

``` bash
    sudo cp ./scripts/proxy/luis122448.dev.conf /etc/nginx/sites-available/luis122448.dev.conf
    sudo cp ./scripts/proxy/luis122448.com.conf /etc/nginx/sites-available/luis122448.com.conf
```

# Habilitar sitio ( enlace simbolico )

```bash
    sudo ln -s /etc/nginx/sites-available/luis122448.com.conf /etc/nginx/sites-enabled/
    sudo ln -s /etc/nginx/sites-available/luis122448.dev.conf /etc/nginx/sites-enabled/
```

# Verificar la validez del certificado

```bash
    sudo openssl x509 -in /etc/letsencrypt/live/luis122448.com/fullchain.pem -text -noout
    sudo openssl x509 -in /etc/letsencrypt/live/luis122448.dev/fullchain.pem -text -noout
```

# Reubica options-ssl-nginx

```bash
    sudo cp ./scripts/proxy/options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
```

# Generar ssl_dhparam

```bash
    sudo openssl dhparam -out /etc/letsencrypt/ssl-dhparams.pem
```

# Reinicia Nginx

```bash
    sudo systemctl restart nginx
```

# Verificar Estatus de la configuración

```bash
    sudo nginx -t
```

# Test connection

```bash
     curl -I http://luis122448.com
     curl -I http://luis122448.dev
```