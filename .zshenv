# Alias
alias tmux='[ ${TMUX} ] || tmux attach || tmux'
alias ls='ls --color=auto'
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias vimpager=$HOME/.vim/bundle/vimpager/vimpager

# Environment variable
export PYTHONPATH=$PYTHONPATH:$HOME/Dropbox/lib/pymodule
export PATH=$PATH:$HOME/Dropbox/bin
export EDITOR=/usr/bin/vi
export PAGER=$HOME/.vim/bundle/vimpager/vimpager
export CPATH=$CPATH:$HOME/Dropbox/lib/cmodule/include
