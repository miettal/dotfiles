# Prezto.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Alias
alias rm='mv -f --backup=numbered --target-directory ~/.trash'
alias emacs=nvim
alias vi=nvim
alias vim=nvim
alias gdb='gdb -q'
alias vimpager='$HOME/dotfiles/vim/dein/repos/github.com/rkitover/vimpager/vimpager'
alias each="find . -type f -print0 | xargs -n 1 -0"
alias update_pip='pip install --upgrade pip; pip freeze --local | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'
alias update_pyenv='cd $HOME/.pyenv;git pull;cd -'
alias update_rbenv='cd $HOME/.rbenv;git pull;cd -'
alias commit='git add .; git commit . -m "quick commit"; git push'
alias shutdown='yes'
alias reboot='yes'
alias halt='yes'

# Environment variable
export PATH=$HOME/dotfiles/myscripts:$PATH
export PATH=$HOME/.vim/bundle/vimpager:$PATH
export EDITOR=vim
export PAGER=$HOME/.vim/bundle/vimpager/vimpager
export XDG_CONFIG_HOME=$HOME/.config
export PYENV_ROOT=$HOME/.pyenv
