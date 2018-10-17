#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

brew install git
brew install mercurial
brew tap brona/iproute2mac
brew install iproute2mac

# for shell
brew install fish
brew install tmux
brew install coreutils

# for c
brew install autoconf
brew install automake

# for vim
brew install neovim
brew install vim
