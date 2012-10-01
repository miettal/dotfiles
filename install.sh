#!/bin/sh

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

echo -n "Choose your machine [ubuntu/mac/...]:"
read distribution

# remove old symbolic link
rm -rf $HOME/.inputrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.vimperatorrc
rm -rf $HOME/.zshrc
# create new symblic link
ln -s $SCRIPT_DIR/.inputrc           $HOME/.inputrc
ln -s $SCRIPT_DIR/.tmux.conf         $HOME/.tmux.conf
ln -s $SCRIPT_DIR/.vim               $HOME/.vim
ln -s $SCRIPT_DIR/.vimrc             $HOME/.vimrc
ln -s $SCRIPT_DIR/.vimperatorrc      $HOME/.vimperatorrc
ln -s $SCRIPT_DIR/.zshrc             $HOME/.zshrc

# remove old .zshenv
rm -rf $HOME/.zshenv
# create new .zshenv
touch $HOME/.zshenv
if [ $distribution = mac ] ; then
	echo "source $SCRIPT_DIR/.zshenv_mac" >> $HOME/.zshenv
fi
echo "source $SCRIPT_DIR/.zshenv" >> $HOME/.zshenv

# install require package
case "$distribution" in
"mac") 
  sudo port install tmux
  sudo port install vim
  sudo port instal lurl
 ;;
"ubuntu")
  yes|sudo apt-get install tmux
  yes|sudo apt-get install zsh
  yes|sudo apt-get install vim
  yes|sudo apt-get install curl
  ;;
*)
 ;;
esac

# change login shell
chsh -s /bin/zsh

# install vim plugin vundle
cd $SCRIPT_DIR
git submodule update --init
cd -

# install vim plugin for vundle
vim +BundleInstall +quit +quit

# executable vimpager
chmod +x $SCRIPT_DIR/.vim/bundle/vimpager/vimpager
