#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    # 系统的python3
    /usr/bin/python3 ~/.vim/plugged/YouCompleteMe/install.py
    # brew的python3
    # /usr/local/bin/python3  ~/.vim/plugged/YouCompleteMe/install.py
else
    python3 ~/.vim/plugged/YouCompleteMe/install.py # --clang-completer
fi
