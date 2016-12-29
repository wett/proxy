#!/bin/bash

clear
sudo echo ""
echo "#############################################################"
echo "# Install  Shadowsocks client                               #"
echo "# Intro: https://github.com/wett/proxy.git                  #"
echo "# Author: Wett Kok <wettkok@gmail.com>                      #"
echo "#############################################################"
echo ""

DIR=${HOME}/.proxy

checkos() {
  printf "checking Operate System\n"
  if  cat /etc/issue | grep -q -E -i "ubuntu"; then
    OS=ubuntu
    printf "detected OS is Ubuntu.\n"
  elif cat /proc/version | grep -q -E -i "ubuntu"; then
    OS=ubuntu
    printf "detected OS is Ubuntu.\n"
  else
    echo "Not supported Operatintg System.\n"
  fi
}

install_ubuntu() {
  sudo apt-get install -y python-pip
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
nohup sslocal -c $DIR/shadowsocks.json  >$DIR/log/shadowsocks.log 2>&1 &
}

# Main Install function
main() {
    checkos
    printf "git cloning https://github.com/wettk/proxy.git\n"
    git clone https://github.com/wettk/proxy.git $DIR
    print "git clone compeleted\n"
    install
    run_config
}

main
