#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###########
### git ###
###########
GIT_DIR=${BASEDIR}/git
ln -s ${GIT_DIR}/gitconfig $HOME/.gitconfig
ln -s ${GIT_DIR}/gitignore_global $HOME/.gitignore_global
ln -s ${GIT_DIR}/plugins/git-completion.sh $HOME/.git-completion.sh
ln -s ${GIT_DIR}/plugins/git-prompt.sh $HOME/.git-prompt.sh

###########
### vim ###
###########
VIM_DIR=${BASEDIR}/vim
ln -s ${VIM_DIR}/vimrc $HOME/.vimrc
ln -s ${VIM_DIR} $HOME/.vim
git submodule init && git submodule update

###########
### fzf ###
###########
${BASEDIR}/vim/bundle/fzf/install --all

############
### tmux ###
############
TMUX_DIR=${BASEDIR}/tmux
if [ `uname` == 'Darwin' ]; then
  brew install tmux
  brew install cmake

  cp  ${TMUX_DIR}/tmux.conf $HOME/.tmux.conf

  echo "set -g default-command 'reattach-to-user-namespace -l ${SHELL}'" >> $HOME/.tmux.conf
  echo "set -g pane-border-style fg='#a9b7c6'" >> $HOME/.tmux.conf

  # leader z for OSX (local) tmux
  echo "set -g prefix C-z" >> $HOME/.tmux.conf
  echo "bind-key C-z send-prefix" >> $HOME/.tmux.conf
elif [ `uname` == 'Linux' ]; then
  sudo apt-get install -y cmake
  sudo apt-get install -y vim-gtk

  # change ownership so that `make install` of the tmux-mem-cpu-load can copy
  # the install to /usr/local/bin
  sudo chown $USER:$USER /usr/local/bin
  cp ${TMUX_DIR}/tmux.conf $HOME/.tmux.conf

  # leader z for OSX (local) tmux
  echo "set -g prefix C-z" >> $HOME/.tmux.conf
  echo "bind-key C-z send-prefix" >> $HOME/tmux.conf
fi

####################
### bash profile ###
####################
cp ${BASEDIR}/bash_profile $HOME/.bash_profile
if [ `uname` == 'Darwin' ]; then
    echo "alias vim=/usr/local/Cellar/vim/8.0.0134_2/bin/vim" >> $HOME/.bash_profile
else
    if command -v nvidia-smi >/dev/null 2&1; then
        echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> $HOME/.bash_profile
        echo "export CUDA_HOME=/usr/local/cuda" >> $HOME/.bash_profile
    fi
fi

CONDA_PATH=$HOME/miniconda3/bin
echo 'export PATH='"$CONDA_PATH"':$PATH' >> $HOME/.bash_profile

#################
### remaining ###
#################
ln -s ${BASEDIR}/inputrc $HOME/.inputrc
ln -s ${BASEDIR}/aliases $HOME/.aliases

# make the tmux-cpu-mem-load plugin
cd ${TMUX_DIR}/plugins/tmux-mem-cpu-load
cmake .
make
make install
cd ${BASEDIR}
