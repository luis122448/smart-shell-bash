#!/bin/bash

echo "Uninstalling Smart Shell..."
sudo docker stop smart-shell-angular
sudo docker stop smart-shell-springboot
sudo docker stop smart-shell-postgres
sudo docker stop smart-shell-redis
sudo docker stop smart-shell-mongo

echo "Removing Smart Shell containers..."
sudo docker rm smart-shell-angular
sudo docker rm smart-shell-springboot
sudo docker rm smart-shell-postgres
sudo docker rm smart-shell-redis
sudo docker rm smart-shell-mongo

echo "Removing Smart Shell networks..."
sudo docker network rm smart-shell-net

echo "Removing Smart Shell volumes..."
sudo rm -rf /var/www/smart-shell/backups
sudo rm -rf /var/www/smart-shell/volumes
sudo rm -rf /var/www/smart-shell/deployments