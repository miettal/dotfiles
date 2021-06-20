#!/usr/bin/env fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
# fisher install oh-my-fish/theme-bobthefish
