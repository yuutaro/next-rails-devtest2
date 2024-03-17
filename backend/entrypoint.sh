#!/bin/bash
set -e

# server.pid ファイルを削除
rm -f /backend/tmp/pids/server.pid

# LOCAL_USER_ID, LOCAL_GROUP_ID からユーザーとグループのIDを取得
USERID=${LOCAL_USER_ID:-1000}
GROUPID=${LOCAL_GROUP_ID:-1000}

# ユーザーとグループの作成
echo "UserName: dockeruser, UserID: $USERID, GroupID: $GROUPID"
groupadd -g $GROUPID dockeruser
useradd -m -s /bin/bash -u $USERID -g $GROUPID dockeruser

# /myapp ディレクトリの所有者を dockeruser に変更
chown -R dockeruser:dockeruser /backend

# コマンドを dockeruser で実行
exec "$@"