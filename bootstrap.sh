#!/bin/bash

DIR=${HOME}/.proxy
REPO=https://github.com/wett/proxy.git
SS_CONFIG_DIR=$DIR/ss-config

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

#  git clone https://github.com/shadowsocks/shadowsocks-libev.git $DIR/shadowsocks-libev
#  cd $DIR/shadowsocks-libev
#  ./configure && make
#  sudo make install

  git clone https://github.com/rofl0r/proxychains-ng.git $DIR/proxychains-ng
  cd $DIR/proxychains-ng
  ./configure --prefix=/usr --sysconfdir=/etc
  make
  sudo make install
}

install() {
    if [ $OS='Ubuntu' ]; then
      install_ubuntu
    fi
}


# Main Install function
main() {
    checkos
    printf "git cloning $REPO\n"
    git clone https://github.com/wettk/proxy.git $DIR
    install
    ln  $DIR/script/ssstart.sh $HOME
    sudo ln -f $DIR/proxychains.conf  /etc/proxychains.conf
    . $DIR/script/ssstart.sh
}

main
