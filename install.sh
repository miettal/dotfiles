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
if [ -e $HOME/.config/fontconfig/fonts.conf ]; then rm -rf $HOME/.config/fontconfig/fonts.conf; fi

mkdir -p $HOME/.config/fontconfig

# create new symblic link
ln -s $SCRIPT_DIR/.inputrc $HOME/.inputrc
ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -s $SCRIPT_DIR/.vim $HOME/.vim
ln -s $SCRIPT_DIR/.vimrc $HOME/.vimrc
ln -s $SCRIPT_DIR/.vimperatorrc $HOME/.vimperatorrc
ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/.config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf

# remove old .zshenv
if [ -e $HOME/.zshenv ]; then       rm -rf $HOME/.zshenv; fi
# create new .zshenv
touch $HOME/.zshenv
echo "source $SCRIPT_DIR/.zshenv" >> $HOME/.zshenv
#create new .vimrc_env
touch $HOME/.vimrc_env

# install require package
case "$distribution" in
"mac") 
  echo "source $SCRIPT_DIR/.zshenv_mac" >> $HOME/.zshenv
  echo "source $SCRIPT_DIR/.vimrc_mac" >> $HOME/.vimrc_env
  sudo ./mac.sh
 ;;
"debian" | "ubuntu")
  echo "source $SCRIPT_DIR/.zshenv_debian" >> $HOME/.zshenv
  sudo ./debian.sh
  ;;
"cygwin")
  ./cygwin.sh
  ;;
*)
  ./other.sh
 ;;
esac

# change login shell
if [ $distribution = cygwin ] ; then
  echo "Please modify your shell manually"
else
  chsh -s /bin/zsh
fi

################################################################################
# for vim                                                                      #
################################################################################
# install vim plugin vundle
cd $SCRIPT_DIR
git submodule update --init
cd -

# install vim plugin for vundle
vim +BundleInstall +quit +quit

# executable vimpager
chmod +x $SCRIPT_DIR/.vim/bundle/vimpager/vimpager

# compile vimproc
cd $SCRIPT_DIR/.vim/bundle/vimproc/
case "$distribution" in
"mac") 
  make -f make_mac.mak
 ;;
"debian" | "ubuntu")
  make -f make_unix.mak
  ;;
"cygwin")
  make -f make_unix.mak
  ;;
*)
  make -f make_unix.mak
 ;;
esac
cd -

################################################################################
# for trash                                                                    #
################################################################################
# create trash directory
if [ ! -d $HOME/.trash ] ; then mkdir $HOME/.trash; fi

################################################################################
# for gEDA                                                                     #
################################################################################
# create .gEDA directory
if [ ! -e $HOME/.gEDA ]; then mkdir $HOME/.gEDA; fi
# remove old .gEDA/gschemrc
if [ -e $HOME/.gEDA/gschemrc ]; then rm -rf $HOME/.gEDA/gschemrc; fi
# create new .gEDA/gschemrc
touch $HOME/.gEDA/gschemrc
echo "(component-library \"$HOME/.gEDA/local_symbols\")" >> $HOME/.gEDA/gschemrc

# create .gEDA/gschemrc directory
if [ ! -e $HOME/.gEDA/local_symbols ]; then mkdir $HOME/.gEDA/local_symbols; fi
cd /tmp
if [ ! -e 4104624 ]; then git clone https://gist.github.com/4104624.git; fi
cp 4104624/KA2311-42B-UR91.sym $HOME/.gEDA/local_symbols
if [ ! -e 4104621 ]; then git clone https://gist.github.com/4104621.git; fi
cp 4104621/74LS574.sym $HOME/.gEDA/local_symbols
if [ ! -e 4444843 ]; then git clone https://gist.github.com/4444843.git; fi
cp 4444843/ATtiny2313.sym $HOME/.gEDA/local_symbols
if [ ! -e 5490805 ]; then git clone https://gist.github.com/5490805.git; fi
cp 5490805/ATmega168.sym $HOME/.gEDA/local_symbols
if [ ! -e 5494499 ]; then git clone https://gist.github.com/5494499.git; fi
cp 5494499/AJ207NWWLWP.sym $HOME/.gEDA/local_symbols
