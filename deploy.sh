#!/bin/bash

# Execute deployment scripts
sudo bash `./scripts/deploy/postgres.sh` &&
sudo bash `./scripts/deploy/redis.sh` &&
sudo bash `./scripts/deploy/mongo.sh` &&
sudo bash `./scripts/deploy/java.sh` &&s
sudo bash `./scripts/deploy/angular.sh`