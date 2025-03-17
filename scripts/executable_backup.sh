#!/bin/env bash
# Backup configuration files to GitHub
# function push() {
#     LOCAL_TIME=$(date "+%Y-%m-%d %H:%M:%S")
#     cd "$1" || exit
#     git add .
#     git commit -m "backup.sh ${LOCAL_TIME}"
#     git push origin main
# }
#
# repos=(
#     # "$HOME/Documents/hledger/"
#     "$HOME/Documents/beancount/"
#     "$HOME/.local/share/chezmoi/"
#     "$HOME/.config/nvim/"
#     "/data/Documents/keepassxc/"
# )
#
# chezmoi_list=(
#     "$HOME/.config/nvim/"
#     "$HOME/.config/yazi/"
# )
#
# printf "\033[32mUpdating dotfiles for chezmoi...\033[0m\n"
# chezmoi add "${chezmoi_list[@]}"
#
# for repo in "${repos[@]}"; do
#     printf "\033[32mBacking up '%s'...\033[0m\n" "$repo"
#     push "$repo" || {
#         echo "Backup failed for $repo"
#         exit 1
#     }
# done

function push() {
    LOCAL_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    cd "$1" || {
        printf "\033[31mFailed to change directory to %s\033[0m\n" "$1"
        exit 1
    }
    git add . || {
        printf "\033[31mFailed to add files to git in %s\033[0m\n" "$1"
        exit 1
    }
    git commit -m "backup.sh ${LOCAL_TIME}" || {
        if ! git status | grep -q 'nothing to commit'; then
            printf "\033[31mFailed to commit changes in %s\033[0m\n" "$1"
            exit 1
        fi
    }
    git push origin main || {
        printf "\033[31mFailed to push changes to origin in %s\033[0m\n" "$1"
        exit 1
    }
}

repos=(
    # "$HOME/Documents/hledger/"
    "$HOME/Documents/beancount/"
    "$HOME/.local/share/chezmoi/"
    "$HOME/.config/nvim/"
    "/data/Documents/keepassxc/"
)

chezmoi_list=(
    "$HOME/.config/nvim/"
    "$HOME/.config/yazi/"
)

printf "\033[32mUpdating dotfiles for chezmoi...\033[0m\n"
chezmoi add "${chezmoi_list[@]}" || printf "\033[31mUpdate failed for chezmoi\033[0m\n"

for repo in "${repos[@]}"; do
    printf "\033[32mBacking up '%s'...\033[0m\n" "$repo"
    push "$repo" || {
        printf "\033[31mBackup failed for %s\033[0m\n" "$repo"
        exit 1
    }
done
printf "\033[32mBackup finished!\033[0m\n"
