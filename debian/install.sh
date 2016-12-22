#!/bin/bash
apt-get install --assume-yes git
apt-get install --assume-yes mercurial
apt-get install --assume-yes build-essential
apt-get install --assume-yes make
apt-get install --assume-yes automake
apt-get install --assume-yes autoconf
apt-get install --assume-yes zsh
apt-get install --assume-yes tmux
apt-get install --assume-yes vim
apt-get install --assume-yes ctags
apt-get install --assume-yes build-essential

apt-get install --assume-yes wget
apt-get install --assume-yes curl

# for python
apt-get install --assume-yes libssl-dev
apt-get install --assume-yes zlib1g-dev
apt-get install --assume-yes libbz2-dev
apt-get install --assume-yes libreadline-dev
apt-get install --assume-yes libsqlite3-dev

# for ruby
apt-get install --assume-yes ruby
apt-get install --assume-yes bison
apt-get install --assume-yes libssl-dev
apt-get install --assume-yes libreadline-dev

# for thefuck
apt-get install --assume-yes python3-dev python3-pip
sudo -H pip3 install thefuck
