#!/bin/bash

jupyter notebook --generate-config
rm ~/.jupyter/jupyter_notebook_config.py
ln -s ~/.dotfiles/jupyter/jupyter_notebook_config.py ~/.jupyter/jupyter_notebook_config.py

conda install -y -c conda-forge jupyter_contrib_nbextensions
jupyter nbextensions_configurator enable --user

mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions

git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
jupyter nbextension enable vim_binding/vim_binding
