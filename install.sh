#!/bin/sh

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

printf "Choose your machine [ubuntu/debian/mac/cygwin/...]:"
read distribution

mkdir -p $HOME/.config/fontconfig

# create new symblic link
ln -f -s $SCRIPT_DIR/.inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/.vim $HOME/.vim
ln -f -s $SCRIPT_DIR/.vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/.vimperatorrc $HOME/.vimperatorrc
ln -f -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -f -s $SCRIPT_DIR/.config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
ln -f -s $SCRIPT_DIR/.gemrc $HOME/.gemrc

# remove old .zshenv
rm -rf $HOME/.zshenv

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
# for pyenv                                                                    #
################################################################################
git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git \
  $HOME/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git \
  $HOME/.pyenv/plugins/pyenv-pip-rehash

export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:${PATH}
eval "$(pyenv init -)"

pyenv install 2.7.8
pyenv install 3.4.1
pyenv install pypy-2.3.1
pyenv install pypy3-2.3.1
pyenv global pypy3-2.3.1

easy_install pip

################################################################################
# for rbenv                                                                    #
################################################################################
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git \
  $HOME/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git \
  $HOME/.rbenv/plugins/rbenv-gem-rehash

export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
eval "$(rbenv init -)"

rbenv install 1.9.3-p547
rbenv install 2.0.0-p481
rbenv global 2.0.0-p481

gem update --system
gem install bundler

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
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

################################################################################
# for vim                                                                      #
################################################################################
# install vim plugin neobundle
cd $SCRIPT_DIR
git submodule update --init
cd -

# install vim plugin for neobundle
vim +quit +quit

################################################################################
# for trash                                                                    #
################################################################################
# create trash directory
mkdir $HOME/.trash

################################################################################
# for gEDA                                                                     #
################################################################################
## create .gEDA directory
#if [ ! -e $HOME/.gEDA ]; then mkdir $HOME/.gEDA; fi
## remove old .gEDA/gschemrc
#if [ -e $HOME/.gEDA/gschemrc ]; then rm -rf $HOME/.gEDA/gschemrc; fi
## create new .gEDA/gschemrc
#touch $HOME/.gEDA/gschemrc
#echo "(component-library \"$HOME/.gEDA/local_symbols\")" >> $HOME/.gEDA/gschemrc
#
## create .gEDA/gschemrc directory
#if [ ! -e $HOME/.gEDA/local_symbols ]; then mkdir $HOME/.gEDA/local_symbols; fi
#cd /tmp
#if [ ! -e 4104624 ]; then git clone https://gist.github.com/4104624.git; fi
#cp 4104624/KA2311-42B-UR91.sym $HOME/.gEDA/local_symbols
#if [ ! -e 4104621 ]; then git clone https://gist.github.com/4104621.git; fi
#cp 4104621/74LS574.sym $HOME/.gEDA/local_symbols
#if [ ! -e 4444843 ]; then git clone https://gist.github.com/4444843.git; fi
#cp 4444843/ATtiny2313.sym $HOME/.gEDA/local_symbols
#if [ ! -e 5490805 ]; then git clone https://gist.github.com/5490805.git; fi
#cp 5490805/ATmega168.sym $HOME/.gEDA/local_symbols
#if [ ! -e 5494499 ]; then git clone https://gist.github.com/5494499.git; fi
#cp 5494499/AJ207NWWLWP.sym $HOME/.gEDA/local_symbols
