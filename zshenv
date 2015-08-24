# Alias
alias tmux='[ ${TMUX} ] || tmux attach || tmux'
alias vi=vim
alias ls='ls --color=auto'
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias vimpager=$HOME/.vim/bundle/vimpager/vimpager
alias vitodo='geeknote edit TODO'
alias cattodo="F=/tmp/\$RANDOM.md;geeknote show TODO | sed -n '7,\$p' | cat > \$F && vim \$F +\"nnoremap q :q<CR>\""
alias each="find . -type f -print0 | xargs -n 1 -0"

# Environment variable
export PATH=$HOME/Dropbox/data/bin:$PATH
export PATH=$HOME/.vim/bundle/vimpager:$PATH
export EDITOR=/usr/bin/vi
export PAGER=$HOME/.vim/bundle/vimpager/vimpager

#C
export CPATH=$HOME/Dropbox/data/lib/cmodule/include:$CPATH

#python
export PYTHONPATH=$HOME/Dropbox/data/lib/pymodule:$PYTHONPATH

#pyenv
if [ -e $HOME/.pyenv ]; then
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:${PATH}
  eval "$(pyenv init -)"
fi

#rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
fi

#heroku
PATH="/usr/local/heroku/bin:$PATH"

#arm-toolchain
PATH="/opt/sat/bin:$PATH"
