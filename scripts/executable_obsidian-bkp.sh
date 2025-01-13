#!/bin/zsh
LOCAL_TIME=$(date -d @$(date +%s) "+%Y/%m/%d-%H:%M")
cd ~/Documents/Obsidian-Vault
if [ "$(git status -s)" ]; then
    git add .
    git commit -m ${LOCAL_TIME}
fi
for (( i=0; i < 10; i++));
do
    if [ "$(git push -u origin main)" ]; then
        break
    fi
done
#while ! git push -u origin main
#    do sleep 1
#    done
