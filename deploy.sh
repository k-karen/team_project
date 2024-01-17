#!/bin/bash

cd /var/www/team_project

git checkout .
git checkout main
git pull
./update_config.sh

export CURRENT_REVISION=$(git show --format='%h' --no-patch)
docker-compose --file docker-compose.production.yml down
docker-compose --file docker-compose.production.yml up -d
