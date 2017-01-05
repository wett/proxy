#!/usr/bin/env bash

DIR=${HOME}/.proxy
REPO=https://github.com/wett/proxy.git
SS_CONFIG_DIR=$DIR/ss-config

printf "shadowsocks is running background\n"

if [ ! -d $DIR/log ]; then
    mkdir $DIR/log
fi

if [ ! -f $DIR/log/shadowsocks.log ]; then
    touch $DIR/log/shadowsocks.log
fi
    

nohup sslocal -c $SS_CONFIG_DIR/ban.json  >$DIR/log/shadowsocks.log 2>&1 &

# waits 5  seconds.
sleep 5s

proxychains4 curl https://google.com

