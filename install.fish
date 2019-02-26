#!/usr/bin/env fish

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
fisher add oh-my-fish/theme-bobthefish
