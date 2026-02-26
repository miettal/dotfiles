#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)

brew update
brew upgrade

brew install the_silver_searcher
brew install lsd
brew install htop
brew install git
brew install git-secrets
brew install mercurial
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

# for git
brew install git-now

# for trash
brew install trash-cli

sudo sh -c 'echo "/opt/homebrew/bin/fish" >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
