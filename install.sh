#!/bin/bash

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

platform=`python $SCRIPT_DIR/platformcheck.py`

mkdir -p $HOME/.config/fontconfig
mkdir -p $HOME/.tasky

ln -f -s $SCRIPT_DIR/gitconfig $HOME/.gitconfig
ln -f -s $SCRIPT_DIR/inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/vim $HOME/.vim
ln -f -s $SCRIPT_DIR/vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/vimperator $HOME/.vimperator
ln -f -s $SCRIPT_DIR/vimperatorrc $HOME/.vimperatorrc
ln -f -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -f -s $SCRIPT_DIR/config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
ln -f -s $SCRIPT_DIR/gemrc $HOME/.gemrc
ln -f -s $SCRIPT_DIR/tasky/keys.txt $HOME/.tasky/keys.txt

rm -rf $HOME/.zshenv
rm -rf $HOME/.vimrc_env

echo "source $SCRIPT_DIR/zshenv" >> $HOME/.zshenv
echo "source $SCRIPT_DIR/vimrc_env" >> $HOME/.vimrc_env

echo "source $SCRIPT_DIR/$platform/zshenv" >> $HOME/.zshenv
echo "source $SCRIPT_DIR/$platform/vimrc_env" >> $HOME/.vimrc_env
sudo "$SCRIPT_DIR/$platform/install.sh"
exit

# change login shell
if [[ $SHELL != "/bin/zsh" ]]; then
  if [[ $platform = "cygwin" ]] ; then
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
git config --global alias.co checkout

################################################################################
# for zsh                                                                      #
################################################################################
git clone git@github.com:robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

################################################################################
# for vim                                                                      #
################################################################################
git clone git@github.com:Shougo/neobundle.vim.git vim/bundle/neobundle.vim

################################################################################
# for trash                                                                    #
################################################################################
# create trash directory
mkdir -p $HOME/.trash

################################################################################
# for tmux                                                                     #
################################################################################
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

################################################################################
# for tasky                                                                    #
################################################################################
git clone git@github.com:miettal/tasky.git $HOME/.tasky_

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
  
  yes n | pyenv install 2.7-dev
  pyenv global 2.7-dev
  
  easy_install pip
  pip install gcalcli
  pip install httplib2
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

