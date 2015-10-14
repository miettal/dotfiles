# Alias
alias tmux='[ ${TMUX} ] || tmux attach || tmux'
alias vi=vim
alias ls='ls --color=auto'
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias vimpager=$HOME/.vim/bundle/vimpager/vimpager
alias each="find . -type f -print0 | xargs -n 1 -0"
alias update_pip="pip install --upgrade pip; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias update_pyenv="cd $HOME/.pyenv;git pull;cd -"
alias update_rbenv="cd $HOME/.rbenv;git pull;cd -"

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
export PATH=/usr/local/heroku/bin:$PATH

#arm-toolchain
export PATH=/opt/sat/bin:$PATH

if [ `pyenv global ` = 'system' ] ; then
fi

