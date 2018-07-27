#!/bin/bash

sudo apt-get update
sudo apt-get upgrade --assume-yes

sudo apt-get install --assume-yes git
sudo apt-get install --assume-yes mercurial
sudo apt-get install --assume-yes zsh
sudo apt-get install --assume-yes tmux
sudo apt-get install --assume-yes ctags
sudo apt-get install --assume-yes wget
sudo apt-get install --assume-yes curl

# for c
sudo apt-get install --assume-yes build-essential
sudo apt-get install --assume-yes make
sudo apt-get install --assume-yes automake
sudo apt-get install --assume-yes autoconf

# for python
sudo apt-get install --assume-yes libssl-dev
sudo apt-get install --assume-yes zlib1g-dev
sudo apt-get install --assume-yes libbz2-dev
sudo apt-get install --assume-yes libreadline-dev
sudo apt-get install --assume-yes libsqlite3-dev

# for ruby
sudo apt-get install --assume-yes ruby
sudo apt-get install --assume-yes bison
sudo apt-get install --assume-yes libssl-dev
sudo apt-get install --assume-yes libreadline-dev

# for vim
sudo apt-get install --assume-yes neovim
sudo apt-get install --assume-yes vim
sudo apt-get install --assume-yes python-neovim
sudo apt-get install --assume-yes python3-neovim
