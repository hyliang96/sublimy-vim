#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    # 系统的python3: 版本太低了
    # /usr/bin/python3 ~/.vim/plugged/YouCompleteMe/install.py
    # brew的python3
    /usr/local/bin/python3  ~/.vim/plugged/YouCompleteMe/install.py
    # mac系统用conda的python3无法编译ycm
else
    python3 ~/.vim/plugged/YouCompleteMe/install.py # --clang-completer
fi
