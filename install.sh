#!/bin/bash

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

uname=`uname -s`

printf "Choose your machine [ubuntu/debian/mac/cygwin/...]:"
read distribution

mkdir -p $HOME/.config/fontconfig

# create new symblic link
ln -f -s $SCRIPT_DIR/gitconfig $HOME/.gitconfig
ln -f -s $SCRIPT_DIR/inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/vim $HOME/.vim
ln -f -s $SCRIPT_DIR/vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/vimperatorrc $HOME/.vimperatorrc
ln -f -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -f -s $SCRIPT_DIR/config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
ln -f -s $SCRIPT_DIR/gemrc $HOME/.gemrc

# remove old .zshenv
rm -rf $HOME/.zshenv

# create new .zshenv
touch $HOME/.zshenv
echo "source $SCRIPT_DIR/zshenv" >> $HOME/.zshenv

#create new .vimrc_env
touch $HOME/.vimrc_env

# install require package
case "$distribution" in
"mac") 
  echo "source $SCRIPT_DIR/zshenv_mac" >> $HOME/.zshenv
  echo "source $SCRIPT_DIR/vimrc_mac" >> $HOME/.vimrc_env
  sudo ./install_mac.sh
 ;;
"debian" | "ubuntu")
  echo "source $SCRIPT_DIR/zshenv_debian" >> $HOME/.zshenv
  sudo ./install_debian.sh
  ;;
"cygwin")
  echo "source $SCRIPT_DIR/zshenv_cygwin" >> $HOME/.zshenv
  ./install_cygwin.sh
  ;;
*)
  ./install_other.sh
 ;;
esac

# change login shell
if [[ $SHELL != "/bin/zsh" ]]; then
  if [[ $distribution = "cygwin" ]] ; then
    echo "Please modify your shell manually"
  else
    chsh -s /bin/zsh
  fi
  echo Re-login
  exit
fi

################################################################################
# for git                                                                      #
################################################################################
git config --global user.name "Hiromasa Ihara"
git config --global user.mail iharahiromasa@gmail.com
git config --global core.editor "/usr/bin/vi"
git config --global alias.co checkout

################################################################################
# for zsh                                                                      #
################################################################################
git clone git@github.com:robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

################################################################################
# for vim                                                                      #
################################################################################
git clone git@github.com:Shougo/neobundle.vim.git vim/bundle/neobundle.vim
yes | vim +quit +quit #todo

################################################################################
# for trash                                                                    #
################################################################################
# create trash directory
mkdir $HOME/.trash

################################################################################
# for tmux                                                                     #
################################################################################
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

################################################################################
# for pyenv                                                                    #
################################################################################
printf "do you want to instal pyenv?[y/n]:"
read yn
case "$yn" in
"y") 
  git clone git@github.com:yyuu/pyenv.git $HOME/.pyenv
  git clone git@github.com:yyuu/pyenv-virtualenv.git \
    $HOME/.pyenv/plugins/pyenv-virtualenv
  git clone git@github.com:yyuu/pyenv-pip-rehash.git \
    $HOME/.pyenv/plugins/pyenv-pip-rehash
  
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:${PATH}
  eval "$(pyenv init -)"
  
  yes n | pyenv install 2.7.8
  pyenv global 2.7.8
  
  easy_install pip
  pip install gcalcli
 ;;
*)
  # no
 ;;
esac

################################################################################
# for rbenv                                                                    #
################################################################################
printf "do you want to instal rbenv?[y/n]:"
read yn
case "$yn" in
"y") 
  git clone git@github.com:sstephenson/rbenv.git $HOME/.rbenv
  git clone git@github.com:sstephenson/ruby-build.git \
    $HOME/.rbenv/plugins/ruby-build
  git clone git@github.com:sstephenson/rbenv-gem-rehash.git \
    $HOME/.rbenv/plugins/rbenv-gem-rehash
  
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
  
  yes n | rbenv install 2.0.0-p481
  rbenv global 2.0.0-p481
  
  gem update --system
  gem install bundler
 ;;
*)
  # no
 ;;
esac

