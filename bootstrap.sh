#!/bin/bash

clear
echo ""
echo "#############################################################"
echo "# Install  Shadowsocks client                               #"
echo "# Intro: https://github.com/tgox/autoproxy.git              #"
echo "# Author: Terry Go <gqlpub@gmail.com>                       #"
echo "#############################################################"
echo ""

DIR=${HOME}/.proxy

checkos() {
    if  cat /etc/issue | grep -q -E -i "ubuntu"; then
        OS=Ubuntu
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
        OS=Ubuntu
    else
        echo "Not supported Operatintg System."
    fi
}

install_ubuntu() {
  apt-get install -y python-pip
  pip install shadowsocks

  git clone https://github.com/rofl0r/proxychains-ng.git ~/.proxy/proxychains-ng
  cd ~/.proxy/proxychains-ng
  ./configure --prefix=/usr --sysconfdir=/etc
  make && sudo make install
}

install() {
    if [ $OS='Ubuntu' ]; then
      install_ubuntu
    fi
}

run_config() {
	echo "running shadowsocks background"
nohup sslocal -c $DIR/shadowsocks.json  >$DIR/log/shadosocks.log 2>&1 &
}

# Main Install function
main() {
    checkos
    git clone https://github.com/wettk/proxy.git ~/.proxy
    install
    run_config
}

autoproxy
