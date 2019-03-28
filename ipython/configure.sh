#!/bin/bash

ipython profile create
rm ~/.ipython/profile_default/ipython_config.py
ln -s ~/.dotfiles/ipython/ipython_config.py ~/.ipython/profile_default/ipython_config.py

conda install -c conda-forge jupyter_contrib_nbextensions
jupyter nbextensions_configurator enable --user

mkdir -p $(jupyter --data-dir)/nbextensions
cd -p $(jupyter --data-dir)/nbextensions

git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding
