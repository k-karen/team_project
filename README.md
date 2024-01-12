## Setup
`docker-compose up`

## 各コマンドの実行方法
`docker exec -it g2_app bash` でrailsが動いてるコンテナに入れます。  
コンテナ内部で `bin/rails g model Hoge` とかすればrailsコマンドが実行できます。

## debug  
ここにVSCodeでのデバッグについて記しました。  
https://github.com/k-karen/team_project/wiki/1.-About-Development-Environment#rails%E3%81%AEvscode-docker%E3%81%AE%E3%83%87%E3%83%90%E3%83%83%E3%82%B0%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

## ローカル環境でのユーザー作成などについて

ホーム
http://localhost:3000/
登録画面
http://localhost:3000/sign_up
ログイン画面
http://localhost:3000/login

## デプロイ手順
### EC2構築時
- sshのportを変更してセキュリティグループも変更しておく(ssh port, 443, 80のinboundを受けるようにする)  
- docker, docker-composeの導入  
- certbotなどで証明書準備  
- WEB_DOMAINにdomainを吐き出す  
- git pullして後述の設定更新  


### 更新時
```bash
cd /var/www/team_project/
# gitを操作してデプロイしたいブランチへ
# e.g.
# 最新mainを確認したい場合
# git checkout main
# git pull
./update_config.sh
docker-compose --file docker-compose.production.yml down
docker-compose --file docker-compose.production.yml -d up
```
