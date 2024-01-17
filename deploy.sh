#!/bin/bash

cd /var/www/team_project

# `./update_config.sh`の影響でファイルが少し書き換わってるので、一旦リセットする必要がある
# TODO: gitignoreのファイルを作ってそれを参照するようにしたほうが良いかも(./update_config.shを変えるということ)
git checkout .
git checkout main
git pull
./update_config.sh

# /current_revのAPIで現在のリビジョンとデプロイ日時を取得できるようにする
export CURRENT_REVISION=$(git show --format='%h' --no-patch)----$(TZ=JST-9 date "+%Y/%m/%d %H:%M:%S")
docker-compose --file docker-compose.production.yml down && docker-compose --file docker-compose.production.yml up -d
