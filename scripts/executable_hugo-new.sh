#!/bin/zsh
cd ~/myblog
echo "Blog title: "
read title
hugo new post/$title/index.md
cd ./content/post/$title
#subl ./index.md
nvim ./index.md
