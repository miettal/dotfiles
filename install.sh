#!/bin/bash

SCRIPT_DIR=`(cd $(dirname $0);pwd)`

platform=`python $SCRIPT_DIR/platformcheck.py`

mkdir -p $HOME/.config/fontconfig

ln -f -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -f -s $SCRIPT_DIR/zlogin $HOME/.zlogin
ln -f -s $SCRIPT_DIR/zlogout $HOME/.zlogout
ln -f -s $SCRIPT_DIR/zprofile $HOME/.zprofile
ln -f -s $SCRIPT_DIR/zpreztorc $HOME/.zpreztorc
ln -f -s $SCRIPT_DIR/gitconfig $HOME/.gitconfig
ln -f -s $SCRIPT_DIR/gitignore $HOME/.gitignore
ln -f -s $SCRIPT_DIR/inputrc $HOME/.inputrc
ln -f -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf
ln -f -s $SCRIPT_DIR/vim $HOME/.vim
ln -f -s $SCRIPT_DIR/vimrc $HOME/.vimrc
ln -f -s $SCRIPT_DIR/vimperator $HOME/.vimperator
ln -f -s $SCRIPT_DIR/vimperatorrc $HOME/.vimperatorrc
ln -f -s $SCRIPT_DIR/config/fontconfig/fonts.conf $HOME/.config/fontconfig/fonts.conf
ln -f -s $SCRIPT_DIR/gemrc $HOME/.gemrc

rm -rf $HOME/.gdbinit
rm -rf $HOME/.zshenv
rm -rf $HOME/.vimrc_env
rm -rf $HOME/.tmux_env

echo "source $SCRIPT_DIR/$platform/zshenv" >> $HOME/.zshenv
echo "source $SCRIPT_DIR/$platform/vimrc_env" >> $HOME/.vimrc_env
echo "source $SCRIPT_DIR/$platform/tmux_env" >> $HOME/.tmux_env

echo "source $SCRIPT_DIR/gdbinit" >> $HOME/.gdbinit
echo "source $SCRIPT_DIR/zshenv" >> $HOME/.zshenv
echo "source $SCRIPT_DIR/vimrc_env" >> $HOME/.vimrc_env
echo "source $SCRIPT_DIR/tmux_env" >> $HOME/.tmux_env

$SCRIPT_DIR/$platform/install.sh

# change login shell
if [[ $SHELL != "/bin/zsh" ]]; then
  if [[ $platform = "cygwin" ]] ; then
    echo "Please modify your shell manually"
  else
    chsh -s /bin/zsh
  fi
  echo Re-login
fi

# private dotfiles
mkdir -p $HOME/.ssh
git clone git@github.com:miettal/dotfiles_private.git $SCRIPT_DIR/dotfiles_private
ln -f -s $SCRIPT_DIR/dotfiles_private/ssh/* $HOME/.ssh/

# zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

# vim
git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim

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
  
  yes n | pyenv install 2.7-dev
  yes n | pyenv install 3.6-dev
  pyenv global 3.6-dev

  pyenv virtualenv 2.7-dev gcalcli
  pyenv virtualenv 2.7-dev tasky
  
  pyenv shell gcalcli
  pip install gcalcli
  pyenv shell --unset

  pyenv shell tasky
  ln -f -s $SCRIPT_DIR/dotfiles_private/tasky/* $HOME/.tasky/
  git clone https://github.com/jrupac/tasky $HOME/.tasky
  ln -f -s $SCRIPT_DIR/tasky/keys.txt $HOME/.tasky
  pip install -r $HOME/.tasky/requirements.txt
  pyenv shell --unset
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
  git clone https://github.com/sstephenson/ruby-build.git \
    $HOME/.rbenv/plugins/ruby-build
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git \
    $HOME/.rbenv/plugins/rbenv-gem-rehash
  
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
  
  yes n | rbenv install 2.4.0-dev
  rbenv global 2.4.0-dev
  
  gem update --system
  gem install bundler
 ;;
*)
  # no
 ;;
esac

# ctf tools
printf "do you want to instal ctf tools?[y/n]:"
read yn
case "$yn" in
"y") 
  mkdir -p $SCRIPT_DIR/ctf
  ln -f -s $SCRIPT_DIR/ctf $HOME/.ctf

  echo 'export PATH=$HOME/.ctf/exiftool/Image-ExifTool-10.10:$PATH' >> $HOME/.zshenv
  echo 'export PATH=$HOME/.ctf/binwalk/src/scripts:$PATH' >> $HOME/.zshenv
  echo 'export PATH=$HOME/.ctf/sqlmap:$PATH' >> $HOME/.zshenv
  echo 'source $HOME/.ctf/peda/peda.py' >> $HOME/.gdbinit
  

  wget -O - http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.10.tar.gz | tar zxf - -C $SCRIPT_DIR/ctf
  git clone https://github.com/devttys0/binwalk.git $SCRIPT_DIR/ctf/binwalk
  git clone https://github.com/sqlmapproject/sqlmap.git $SCRIPT_DIR/ctf/sqlmap
  git clone https://github.com/longld/peda.git $SCRIPT_DIR/ctf/peda
 ;;
*)
  # no
 ;;
esac

