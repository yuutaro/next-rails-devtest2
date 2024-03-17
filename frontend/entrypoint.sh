#!/bin/bash
set -e

USERID=${LOCAL_USER_ID:-1000}
GROUPID=${LOCAL_GROUP_ID:-1000}

echo "UserName: node, UserID: $USERID, GroupID: $GROUPID"

#一時的なグループを作成
groupadd -g 11111 tempgroup

# 「node」ユーザーを一時的なグループにいったん所属させる
usermod -g tempgroup node

# もともと所属していたnodeグループを削除
groupdel node

# ホストユーザーのGIDと同じGIDでnodeグループを作成
groupadd -g $GROUPID node

# nodeユーザーのGIDをホストユーザーのGIDに設定
usermod -g $GROUPID node

# nodeユーザーのUIDをホストユーザーのUIDに設定
usermod -u $USERID node

# 一時的なグループを削除
groupdel tempgroup

chown -R node:node /frontend

exec "$@"