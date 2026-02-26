#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)

pip3 install distro
platform=$(python3 $SCRIPT_DIR/platformcheck.py)

mkdir -p $HOME/.local
mkdir -p $HOME/.local/bin

mkdir -p $HOME/.vim
mkdir -p $HOME/.config/
mkdir -p $HOME/.config/fontconfig
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/fish

ln -f -s $SCRIPT_DIR/config.fish $HOME/.config/fish/config.fish
ln -f -s $SCRIPT_DIR/fishfile $HOME/.config/fish/fishfile
ln -f -s $SCRIPT_DIR/gitconfig $HOME/.gitconfig
ln -f -s $SCRIPT_DIR/gitignore $HOME/.gitignore
ln -f -s $SCRIPT_DIR/inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/init.lua $HOME/.config/nvim/init.lua
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

# trash
mkdir -p $HOME/.trash

# pyenv
printf "do you want to instal pyenv?[y/n]:"
read yn
case "$yn" in
"y")
  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
  git clone https://github.com/pyenv/pyenv-pip-rehash.git $HOME/.pyenv/plugins/pyenv-pip-rehash
  git clone https://github.com/pyenv/pyenv-update.git $HOME/.pyenv/plugins/pyenv-update

  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:${PATH}
  eval "$(pyenv init -)"

  pyenv global system

  pyenv update
  pyenv install --skip-existing 3.11-dev
  pyenv install --skip-existing 3.12-dev
  pyenv install --skip-existing 3.13-dev
  pyenv install --skip-existing 3.14-dev
  pyenv global 3.14-dev

  pip install flake8 autopep8 isort
  pip install --user jedi --upgrade
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
  git clone https://github.com/rkh/rbenv-update.git $HOME/.rbenv/plugins/rbenv-update

  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"

  rbenv update
  rbenv install --skip-existing 3.0.0-dev
  rbenv install --skip-existing 3.1.0-dev
  rbenv install --skip-existing 3.2.0-dev
  rbenv install --skip-existing 3.3.0-dev

  gem update --system
  gem install bundler
 ;;
*)
  # no
 ;;
esac

$SCRIPT_DIR/install.fish
