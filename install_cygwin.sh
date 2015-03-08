#!/bin/sh

wget https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
chmod 755 apt-cyg
mv apt-cyg /usr/local/bin/
chmod 0755 /usr/local/bin/apt-cyg
apt-cyg update

apt-cyg install tmux
apt-cyg install zsh
apt-cyg install vim
apt-cyg install curl
apt-cyg install openssl
apt-cyg install readline
apt-cyg install libiconv
apt-cyg install ctags
