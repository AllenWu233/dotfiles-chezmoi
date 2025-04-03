#!/bin/env bash
# Backup configuration files to GitHub

# Repository list
repos=(
    "$HOME/Documents/beancount"
    "$HOME/.local/share/chezmoi"
    "$HOME/.config/nvim"
    "/data/Documents/keepassxc"
)

# Chezmoi tracked paths
chezmoi_paths=(
    "$HOME/.config/nvim"
    "$HOME/.config/yazi"
    "$HOME/scripts"
)

ESC="\e["
GREEN="${ESC}32m"
RED="${ESC}31m"
RESET="${ESC}0m"

pull_and_push() {
    local repo_path="$1"
    local commit_msg="backup.sh $(date '+%Y-%m-%d %H:%M:%S')"

    echo -e "${GREEN}Processing repository: $repo_path${RESET}"

    if ! cd "$repo_path"; then
        echo -e "${RED}Error: Failed to enter directory $repo_path${RESET}" >&2
        return 1
    fi

    # Pull changes first
    if ! git pull; then
        echo -e "${RED}Error: Failed to pull changes in $repo_path${RESET}" >&2
        return 1
    fi

    # Stage all changes
    git add . || {
        echo -e "${RED}Error: Failed to stage files in $repo_path${RESET}" >&2
        return 1
    }

    # Commit only if there are changes
    if ! git diff --cached --quiet; then
        if ! git commit -m "$commit_msg"; then
            echo -e "${RED}Error: Failed to commit changes in $repo_path${RESET}" >&2
            return 1
        fi
    else
        echo -e "No changes to commit in $repo_path"
    fi

    # Push changes
    if ! git push -u origin main; then
        echo -e "${RED}Error: Failed to push changes in $repo_path${RESET}" >&2
        return 1
    fi

    return 0
}

echo -e "${GREEN}Updating dotfiles with chezmoi...${RESET}"
chezmoi add "${chezmoi_paths[@]}" || echo -e "${RED}Warning: Chezmoi update failed${RESET}"

# Process repositories
for repo in "${repos[@]}"; do
    if ! pull_and_push "$repo"; then
        echo -e "${RED}Backup failed for $repo${RESET}" >&2
        exit 1
    fi
done

echo -e "${GREEN}All backups completed successfully!${RESET}"
