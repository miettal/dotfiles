# Source Prezto.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Alias
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias emacs=vim
alias vi=vim
alias gdb='gdb -q'
alias vimpager='$HOME/.vim/bundle/vimpager/vimpager'
alias each="find . -type f -print0 | xargs -n 1 -0"
alias update_pip='pip install --upgrade pip; pip freeze --local | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'
alias update_pyenv='cd $HOME/.pyenv;git pull;cd -'
alias update_rbenv='cd $HOME/.rbenv;git pull;cd -'
alias commit='git commit . -m "quick commit"; git push origin master'
alias task='gcalcli --military --width $((($COLUMNS-8)/7)) calw 2;python $HOME/.tasky_/tasky.py --list'
alias shutdown='yes'
alias reboot='yes'
alias halt='yes'

# Environment variable
export PATH=$HOME/dotfiles/myscripts:$PATH
export PATH=$HOME/.vim/bundle/vimpager:$PATH
export EDITOR=vim
export PAGER=$HOME/.vim/bundle/vimpager/vimpager

#C
export CPATH=$HOME/Dropbox/data/lib/cmodule/include:$CPATH

#python
export PYTHONPATH=$HOME/Dropbox/data/lib/pymodule:$PYTHONPATH

#pyenv
if [[ -e $HOME/.pyenv ]]; then
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
  eval "$(pyenv init -)"
fi

#rbenv
if [[ -e $HOME/.rbenv ]]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
