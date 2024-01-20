#!/bin/bash

LOCK_FILE="/tmp/deploy.lock"
MAX_WAIT=300 # 最大待機時間（秒）

# ロックファイルの存在をチェック
if [ -f "$LOCK_FILE" ]; then
  echo "別のデプロイスクリプトが実行中です。終了を待っています..."
  wait_time=0
  while [ -f "$LOCK_FILE" ]; do
    sleep 5
    wait_time=$((wait_time + 5))
    echo "別のデプロイスクリプトが実行中です。終了を待っています...(${wait_time}秒経過)"

    # タイムアウトチェック
    if [ "$wait_time" -ge "$MAX_WAIT" ]; then
      echo "最大待機時間に達しました。デプロイを続行します。"
      break
    fi
  done
fi

# ロックファイルを作成
touch "$LOCK_FILE"

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

# ロックファイルを削除
rm -f "$LOCK_FILE"
