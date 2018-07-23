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

alias rm='mv -f --backup=numbered --target-directory ~/.trash'

tmux rename -t prezto $(hostname) 2> /dev/null
