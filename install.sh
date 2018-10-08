#!/bin/bash

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

platform=`python $SCRIPT_DIR/platformcheck.py`

mkdir -p $HOME/.config/fontconfig
mkdir -p $HOME/.config/nvim

ln -f -s $SCRIPT_DIR/config.fish $HOME/.config/fish/config.fish
ln -f -s $SCRIPT_DIR/fishfile $HOME/.config/fish/fishfile
ln -f -s $SCRIPT_DIR/gitconfig $HOME/.gitconfig
ln -f -s $SCRIPT_DIR/gitignore $HOME/.gitignore
ln -f -s $SCRIPT_DIR/inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/vim $HOME/.vim
ln -f -s $SCRIPT_DIR/vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/vim $HOME/.config/nvim/
ln -f -s $SCRIPT_DIR/vimrc $HOME/.config/nvim/init.vim
ln -f -s $SCRIPT_DIR/vimperator $HOME/.vimperator
ln -f -s $SCRIPT_DIR/vimperatorrc $HOME/.vimperatorrc
ln -f -s $SCRIPT_DIR/config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
ln -f -s $SCRIPT_DIR/gemrc $HOME/.gemrc

rm -rf $HOME/.gdbinit
rm -rf $HOME/.vimrc_env
rm -rf $HOME/.tmux_env

echo "source $SCRIPT_DIR/$platform/vimrc_env" >> $HOME/.vimrc_env
echo "source $SCRIPT_DIR/$platform/tmux_env" >> $HOME/.tmux_env

echo "source $SCRIPT_DIR/gdbinit" >> $HOME/.gdbinit
echo "source $SCRIPT_DIR/vimrc_env" >> $HOME/.vimrc_env
echo "source $SCRIPT_DIR/tmux_env" >> $HOME/.tmux_env

$SCRIPT_DIR/$platform/install.sh

# private dotfiles
mkdir -p $HOME/.ssh
git clone git@github.com:miettal/dotfiles_private.git $SCRIPT_DIR/dotfiles_private
ln -f -s $SCRIPT_DIR/dotfiles_private/ssh/* $HOME/.ssh/

# zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

# vim
mkdir -p $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim.git $HOME/.vim/dein/repos/github.com/Shougo/dein.vim

# trash directory
mkdir -p $HOME/.trash

# pyenv
printf "do you want to instal pyenv?[y/n]:"
read yn
case "$yn" in
"y")
  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  git clone https://github.com/pyenv/pyenv-pip-rehash.git $HOME/.pyenv/plugins/pyenv-pip-rehash
  git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv

  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:${PATH}
  eval "$(pyenv init -)"

  pyenv global system
  pip3 install neovim

  pyenv install --skip-existing 2.7-dev
  pyenv install --skip-existing 3.6-dev
  pyenv global 3.6-dev
 ;;
*)
  # no
 ;;
esac

# rbenv
printf "do you want to instal rbenv?[y/n]:"
read yn
case "$yn" in
"y") 
  git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash

  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"

  rbenv install --skip-existing 2.4.0-dev
  rbenv global 2.6.0-dev

  gem update --system
  gem install bundler
 ;;
*)
  # no
 ;;
esac
