#!/bin/bash

git config --global --add safe.directory "/var/www/smart-shell/deployments"

# Execute deployment scripts
bash /var/www/smart-shell/configurations/smart-shell-bash/scripts/deploy/postgres.sh &&
bash /var/www/smart-shell/configurations/smart-shell-bash/scripts/deploy/mongo.sh &&
bash /var/www/smart-shell/configurations/smart-shell-bash/scripts/deploy/redis.sh &&
bash /var/www/smart-shell/configurations/smart-shell-bash/scripts/deploy/java.sh &&
bash /var/www/smart-shell/configurations/smart-shell-bash/scripts/deploy/angular.sh
