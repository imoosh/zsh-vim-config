#!/bin/bash
# Created by Wayne, 2022.7.29

PWD=$(readlink -f "$(dirname "$0")")

yum install -y $PWD/rpm/vim/*.rpm 2>&-
yum install -y $PWD/rpm/ctags/*.rpm 2>&-

function backup_vimconfig() {
  rm -rf $HOME/.bakvim 2>&-
  mkdir $HOME/.bakvim 2>&-
  cp $HOME/.vim $HOME/.bakvim -a 2>&-
  cp $HOME/.vimrc $HOME/.bakvim 2>&-
  cp $HOME/.bashrc $HOME/.bakvim 2>&-
}

function config_vim() {
  rm -rf $HOME/.vim 2>&-
  cp $PWD/.vim $HOME -a 2>&-
  cp $PWD/.vimrc $HOME 2>&-
  cp $PWD/.bashrc $HOME 2>&-
  cp $PWD/cindex /usr/bin/ 2>&-
  chmod +x /usr/bin/cindex 2>&-

  cd /usr/include
  ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q
}

backup_vimconfig
config_vim

mv /usr/bin/vi /usr/bin/vi-bak
ln -s /usr/bin/vim /usr/bin/vi
