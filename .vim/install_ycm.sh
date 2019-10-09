#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    /usr/bin/python  ~/.vim/plugged/YouCompleteMe./install.py
else
     ~/.vim/plugged/YouCompleteMe./install.py
fi
