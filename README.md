## コマンド一覧
- composeで定義されたネットワークとその中にあるコンテナ（サービスの起動）  

  ```
  docker compose up
  ```
- ネットワーク内のコンテナ内にルートユーザーで入る方法（ルートユーザー）  

  ```
  docker compose exec <service> <command>
  docker compose exec backend /bin/bash
  docker compose exec frontend /bin/bash
  ```
- ネットワーク内のコンテナ内に特定のユーザーで入る方法（ユーザー）  
  ```
  docker compose exec -u <user> <service> <command>
  docker compose exec -u dockeruser backend /bin/bash
  docker compose exec -u node frontend /bin/bash
  ```
- コンテナ内でのRailsサーバー起動法  
  ```
  rails s -b '0.0.0.0'
  ```

- dockerfileをdocker-composeでビルドする方法  
  ```
  docker compose build --no-cache
  ```

## dockerコンテナ内でのユーザー作成
dockerコンテナ内でdockeruserなるユーザーを作成し、そのUIDとGIDをホストマシンのユーザーのUIDとGIDに一致させることでコンテナ内で作成されたファイルの所有者をホスト側と同一のものにできる。

[Dockerコンテナの実行ユーザーと権限の関係](https://qiita.com/yitakura731/items/36a2ba117ccbc8792aa7)  
[docker-composeで起動したプロセスのUID、GIDをホストユーザと同じにする](https://qiita.com/shun_xx/items/5608e553a16d94afacd2)  
を参照

dockerコンテナ起動時に実行されるentrypoint.sh内で、ホストと同じUIDとGIDを持った"dockeruser"という名のユーザーを作成する。ホストのUID、GIDは、docker-compose.ymlのサービス内（今回はrails）に環境変数として渡し、entrypoint.shは渡された環境変数をもとにdockeruserを作成する。

なお、ホストユーザーのUID,GIDがわからないときは```id```を実行すると確認できる。

このプロセスで作成されたコンテナはdockeruserを持つため、コンテナ内に入るときはそのユーザーを用いて入る。
特定のユーザーで起動中のコンテナに入るには、
```
docker-compose exec -u <user> <service_name> <command>
docker-compose exec -u dockeruser backend /bin/bash
```

を実行する。