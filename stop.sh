#!/bin/bash

# Stop containers
sudo docker stop smart-shell-postgres
sudo docker stop smart-shell-redis
sudo docker stop smart-shell-mongo
sudo docker stop smart-shell-springboot
sudo docker stop smart-shell-angular