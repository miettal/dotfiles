#!/bin/sh

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

echo -n "Is this machine mac?[y/n]:"
read distribution

rm -rf $HOME/.inputrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.vimperatorrc
rm -rf $HOME/.zshrc
rm -rf $HOME/.zshenv

ln -s $SCRIPT_DIR/.inputrc           $HOME/.inputrc
ln -s $SCRIPT_DIR/.tmux.conf         $HOME/.tmux.conf
ln -s $SCRIPT_DIR/.vim               $HOME/.vim
ln -s $SCRIPT_DIR/.vimrc             $HOME/.vimrc
ln -s $SCRIPT_DIR/.vimperatorrc      $HOME/.vimperatorrc
ln -s $SCRIPT_DIR/.zshrc             $HOME/.zshrc
touch $HOME/.zshenv
echo "source $SCRIPT_DIR/.zshenv" >> $HOME/.zshenv
if [ $distribution = y ] ; then
	echo "source $SCRIPT_DIR/.zshenv_mac" >> $HOME/.zshenv
fi
