#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# git
GIT_DIR=${BASEDIR}/git
ln -s ${GIT_DIR}/gitconfig ~/.gitconfig
ln -s ${GIT_DIR}/gitignore_global ~/.gitignore_global
ln -s ${GIT_DIR}/plugins/git-completion.sh ~/.git-completion.sh
ln -s ${GIT_DIR}/plugins/git-prompt.sh ~/.git-prompt.sh

# vim
VIM_DIR=${BASEDIR}/vim
ln -s ${VIM_DIR}/vimrc ~/.vimrc
ln -s ${VIM_DIR} ~/.vim
git submodule init && git submodule update

# tmux
TMUX_DIR=${BASEDIR}/tmux
if [ `uname` == 'Darwin' ]; then
  brew install tmux
  brew install cmake
  cp  ${TMUX_DIR}/tmux.conf ~/.tmux.conf
  echo "set -g default-terminal 'xterm-256color'" >> ~/.tmux.conf
  echo "set -g default-command 'reattach-to-user-namespace -l ${SHELL}'" >> ~/.tmux.conf
  echo "set -g pane-border-style fg='#a9b7c6'" >> ~/.tmux.conf
elif [ `uname` == 'Linux' ]; then
  sudo apt-get install -y cmake
  # change ownership so that `make install` of the tmux-mem-cpu-load can copy
  # the install to /usr/local/bin
  sudo chown $USER:$USER /usr/local/bin
  ln -s ${TMUX_DIR}/tmux.conf ~/.tmux.conf
fi

# bash profile + remaining
ln -s ${BASEDIR}/bash_profile ~/.bash_profile
ln -s ${BASEDIR}/inputrc ~/.inputrc
ln -s ${BASEDIR}/aliases ~/.aliases

# make the tmux-cpu-mem-load plugin
cd ${TMUX_DIR}/plugins/tmux-mem-cpu-load
cmake .
make
make install
cd ${BASEDIR}
