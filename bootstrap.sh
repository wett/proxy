#!/bin/bash

DIR=${HOME}/.proxy
REPO=https://github.com/wett/proxy.git

clear
sudo printf "\n"
printf "#############################################################\n"
printf " Install  Shadowsocks client                              \n"
printf " Intro: $REPO                                              \n"
printf " Author: Wett Kok <wettkok@gmail.com>                      \n"
printf "#############################################################\n"
printf "\n"

checkos() {
  printf "checking Operate System\n"
  if  cat /etc/issue | grep -q -E -i "ubuntu"; then
    OS=ubuntu
    printf "detected OS is Ubuntu.\n"
  elif cat /proc/version | grep -q -E -i "ubuntu"; then
    OS=ubuntu
    printf "detected OS is Ubuntu.\n"
  else
    printf "Not supported Operatintg System.\n"
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
	printf "running shadowsocks background"
nohup sslocal -c $DIR/shadowsocks.json  >$DIR/log/shadowsocks.log 2>&1 &
}

# Main Install function
main() {
    checkos
    printf "git cloning $REPO\n"
    git clone https://github.com/wettk/proxy.git $DIR
    install
    run_config
}

main
