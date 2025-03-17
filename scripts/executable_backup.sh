#!/bin/env bash
# Backup configuration files to GitHub
function push() {
    LOCAL_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    cd "$1" || exit
    git add .
    git commit -m "backup.sh ${LOCAL_TIME}"
    git push origin main
}

repos=(
    # "$HOME/Documents/hledger/"
    "$HOME/Documents/beancount/"
    "$HOME/.local/share/chezmoi/"
    "$HOME/.config/nvim/"
    "/data/Documents/keepassxc/"
)

chezmoi re-add

for repo in "${repos[@]}"; do
    printf "\033[32mBacking up %s\033[0m\n" "$repo"
    push "$repo"
done
