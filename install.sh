#!/bin/sh

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

printf "Choose your machine [ubuntu/debian/mac/cygwin/...]:"
read distribution

# remove old symbolic link
if [ -e $HOME/.inputrc ]; then rm -rf $HOME/.inputrc; fi
if [ -e $HOME/.tmux.conf ]; then rm -rf $HOME/.tmux.conf; fi
if [ -e $HOME/.vim ]; then rm -rf $HOME/.vim; fi
if [ -e $HOME/.vimrc ]; then rm -rf $HOME/.vimrc; fi
if [ -e $HOME/.vimperatorrc ]; then rm -rf $HOME/.vimperatorrc; fi
if [ -e $HOME/.zshrc ]; then rm -rf $HOME/.zshrc; fi

# create new symblic link
ln -s $SCRIPT_DIR/.inputrc           $HOME/.inputrc
ln -s $SCRIPT_DIR/.tmux.conf         $HOME/.tmux.conf
ln -s $SCRIPT_DIR/.vim               $HOME/.vim
ln -s $SCRIPT_DIR/.vimrc             $HOME/.vimrc
ln -s $SCRIPT_DIR/.vimperatorrc      $HOME/.vimperatorrc
ln -s $SCRIPT_DIR/.zshrc             $HOME/.zshrc

# remove old .zshenv
if [ -e $HOME/.zshenv ]; then rm -rf $HOME/.zshenv; fi
# create new .zshenv
touch $HOME/.zshenv
echo "source $SCRIPT_DIR/.zshenv" >> $HOME/.zshenv
if [ $distribution = mac ] ; then
	echo "source $SCRIPT_DIR/.zshenv_mac" >> $HOME/.zshenv
fi

# install require package
case "$distribution" in
"mac") 
  sudo port install tmux
  sudo port install vim
  sudo port install curl
 ;;
"debian" | "ubuntu")
  yes|sudo apt-get install tmux
  yes|sudo apt-get install zsh
  yes|sudo apt-get install vim
  yes|sudo apt-get install curl
  ;;
"cygwin")
  ;;
*)
 ;;
esac

# change login shell
if [ $distribution = cygwin ] ; then
  echo "Please modify your shell manually"
else
  chsh -s /bin/zsh
fi

# install vim plugin vundle
cd $SCRIPT_DIR
git submodule update --init
cd -

# install vim plugin for vundle
vim +BundleInstall +quit +quit

# executable vimpager
chmod +x $SCRIPT_DIR/.vim/bundle/vimpager/vimpager

# create trash directory
if [ ! -d $HOME/.trash ] ; then
  mkdir $HOME/.trash
fi

# for gEDA
