#!/bin/zsh
LOCAL_TIME=$(date -d @$(date +%s) "+%Y/%m/%d-%H:%M")
WORK_PATH=$(pwd)
cd "$1"  # receive argument if exists
if [ "$(git log)" ]; then
    if [ "$(git status -s)" ]; then
        git add .
        git commit -m ${LOCAL_TIME}    
    fi
    while ! git push -u origin main
    do sleep 1
    done
    echo "Succeed!"
else
    echo "Failed!"
fi
cd ${WORK_PATH}
