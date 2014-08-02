# Alias
alias tmux='[ ${TMUX} ] || tmux attach || tmux'
alias ls='ls --color=auto'
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias vimpager=$HOME/.vim/bundle/vimpager/vimpager
alias vitodo='geeknote edit TODO'
alias cattodo="F=/tmp/\$RANDOM.md;geeknote show TODO | sed -n '7,\$p' | cat > \$F && vim \$F +\"nnoremap q :q<CR>\""

# Environment variable
export PYTHONPATH=$HOME/Dropbox/data/lib/pymodule:$PYTHONPATH
export PATH=$HOME/Dropbox/data/bin:$PATH
export PATH=$HOME/.vim/bundle/vimpager:$PATH
export EDITOR=/usr/bin/vi
export PAGER=$HOME/.vim/bundle/vimpager/vimpager
export CPATH=$HOME/Dropbox/data/lib/cmodule/include:$CPATH
