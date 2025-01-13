#!/bin/zsh
pkill fcitx5
rime_deployer --build ~/.local/share/fcitx5/rime/ /usr/share/rime-data ~/.local/share/fcitx5/rime/build
env LANGUAGE=zh_CN fcitx5 &> /dev/null &
