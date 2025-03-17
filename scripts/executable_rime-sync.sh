#!/bin/bash
pkill fcitx5
cd ~/.local/share/fcitx5/rime/
rime_dict_manager -s
env LANGUAGE=zh_CN fcitx5 &> /dev/null &    # hide stdout and strerr output
