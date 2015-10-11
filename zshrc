# LANG環境変数
export LANG=ja_JP.UTF-8

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="crcandy"
DISABLE_LS_COLORS=true
plugins=(git osx tmux autojump battery vi-mode debian web-search zsh_reaload gnu-utils)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
source $ZSH/oh-my-zsh.sh

# 履歴の保存先
HISTFILE=$HOME/.zsh-history
# メモリに展開する履歴の数
HISTSIZE=100000
# 保存する履歴の数
SAVEHIST=100000

autoload -U compinit
compinit -u

eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

gcalcli calw &
clear
