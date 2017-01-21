#!/bin/bash

ipython profile create
rm ~/.ipython/profile_default/ipython_config.py
ln -s ~/.dotfiles/ipython/ipython_config.py ~/.ipython/profile_default/ipython_config.py
