# LANG環境変数
export LANG="ja_JP.UTF-8"

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="crcandy"
DISABLE_LS_COLORS=true
plugins=(git osx tmux autojump battery vi-mode debian zsh_reaload gnu-utils)
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

if [ ! -e $HOME/dotfiles/print ]; then
  #google calendar
  (zsh -c 'gcalcli --military --width $((($COLUMNS-8)/7)) calw 2 > /tmp/com.miettal.gcalcli.$$ && cp /tmp/com.miettal.gcalcli.$$ /tmp/com.miettal.gcalcli'&)
  ls /tmp/com.miettal.gcalcli > /dev/null 2>&1 || touch /tmp/com.miettal.gcalcli
  cat /tmp/com.miettal.gcalcli | tail -n $((`cat /tmp/com.miettal.gcalcli | wc -l ` - 1 ))
  
  #google task
  (zsh -c 'python $HOME/.tasky_/tasky.py --list > /tmp/com.miettal.tasky.$$ && cp /tmp/com.miettal.tasky.$$ /tmp/com.miettal.tasky'&)
  ls /tmp/com.miettal.tasky > /dev/null 2>&1 || touch /tmp/com.miettal.tasky
  cat /tmp/com.miettal.tasky | tail -n $((`cat /tmp/com.miettal.tasky | wc -l ` - 1 ))
fi

#echo -n "\x1b[5;30m進捗どうですか？"
echo -n "\x1b[1;4;5;31m進捗どうですか？"
echo -n "\x1b[1;4;5;32m進捗どうですか？"
echo -n "\x1b[1;4;5;33m進捗どうですか？"
echo
echo -n "\x1b[1;4;5;34m進捗どうですか？"
echo -n "\x1b[1;4;5;35m進捗どうですか？"
echo -n "\x1b[1;4;5;36m進捗どうですか？"
echo
