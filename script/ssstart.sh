#!/usr/bin/env bash

printf "shadowsocks is running background\n“

nohup sslocal -c $SS_CONFIG_DIR/sslink.json  >$DIR/log/shadowsocks.log 2>&1 &

# waits 5  seconds.
sleep 5s

proxychains4 curl https://google.com
