# Alias
alias tmux='[ ${TMUX} ] || tmux attach || tmux'
alias ls='ls --color=auto'
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias vimpager=$HOME/.vim/bundle/vimpager/vimpager

# Environment variable
export PYTHONPATH=$HOME/Dropbox/data/lib/pymodule:$PYTHONPATH
export PATH=$HOME/Dropbox/data/bin:$PATH
export PATH=$HOME/.vim/bundle/vimpager:$PATH
export EDITOR=/usr/bin/vi
export PAGER=$HOME/.vim/bundle/vimpager/vimpager
export CPATH=$HOME/Dropbox/data/lib/cmodule/include:$CPATH
