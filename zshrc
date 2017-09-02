export LC_ALL="ja_JP.UTF-8"
export LANG="ja_JP.UTF-8"

# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#pyenv
export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
eval "$(pyenv init - --no-rehash)"

#rbenv
export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
eval "$(rbenv init - --no-rehash)"

if [ -e $HOME/dotfiles/print ]; then
  pyenv shell 2.7-dev
  (zsh -c 'curl -s wttr.in/Tokyo > /tmp/com.miettal.weather.$$ && cp -f /tmp/com.miettal.weather.$$ /tmp/com.miettal.weather'&)
  ls /tmp/com.miettal.weather > /dev/null 2>&1 || touch /tmp/com.miettal.weather
  cat /tmp/com.miettal.weather | head -n 7

  #google calendar
  (zsh -c '$HOME/dotfiles/back_task/gcalcli.sh'&)
  ls /tmp/com.miettal.gcalcli > /dev/null 2>&1 || touch /tmp/com.miettal.gcalcli
  cat /tmp/com.miettal.gcalcli | tail -n $((`cat /tmp/com.miettal.gcalcli | wc -l ` - 1 )) | head -n $((`cat /tmp/com.miettal.gcalcli | wc -l ` - 2 ))
  
  #google task
  (zsh -c '$HOME/dotfiles/back_task/tasky.sh'&)
  ls /tmp/com.miettal.tasky > /dev/null 2>&1 || touch /tmp/com.miettal.tasky
  cat /tmp/com.miettal.tasky | tail -n $((`cat /tmp/com.miettal.tasky | wc -l ` - 1 ))

  pyenv shell --unset
fi

alias rm='mv -f --backup=numbered --target-directory ~/.trash'
