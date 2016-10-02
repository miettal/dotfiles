export LC_ALL='ja_JP.UTF-8'
export LANG="ja_JP.UTF-8"

# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -e $HOME/dotfiles/print ]; then
  pyenv shell 2.7-dev
  (zsh -c 'curl -s wttr.in > /tmp/com.miettal.weather.$$ && cp -f /tmp/com.miettal.weather.$$ /tmp/com.miettal.weather'&)
  ls /tmp/com.miettal.weather > /dev/null 2>&1 || touch /tmp/com.miettal.weather
  cat /tmp/com.miettal.weather | head -n 7

  #google calendar
  (zsh -c 'gcalcli agenda > /tmp/com.miettal.gcalcli.$$ && cp -f /tmp/com.miettal.gcalcli.$$ /tmp/com.miettal.gcalcli'&)
  ls /tmp/com.miettal.gcalcli > /dev/null 2>&1 || touch /tmp/com.miettal.gcalcli
  cat /tmp/com.miettal.gcalcli | tail -n $((`cat /tmp/com.miettal.gcalcli | wc -l ` - 1 )) | head -n $((`cat /tmp/com.miettal.gcalcli | wc -l ` - 2 ))
  
  #google task
  (zsh -c 'python $HOME/.tasky/tasky.py --list > /tmp/com.miettal.tasky.$$ && cp -f /tmp/com.miettal.tasky.$$ /tmp/com.miettal.tasky'&)
  ls /tmp/com.miettal.tasky > /dev/null 2>&1 || touch /tmp/com.miettal.tasky
  cat /tmp/com.miettal.tasky | tail -n $((`cat /tmp/com.miettal.tasky | wc -l ` - 1 ))

  pyenv shell --unset
fi

if [[ ! -n $TMUX ]]; then
  tmux a -d -t "zshrc"|| tmux new-session -s "zshrc"
fi

