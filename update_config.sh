#!/bin/bash

sed -i "s/REPLACE_ME_BY_DOMAIN/$WEB_DOMAIN/g" docker-compose.production.yml
sed -i "s/REPLACE_ME_BY_DOMAIN/$WEB_DOMAIN/g" dockers/nginx/nginx.conf
