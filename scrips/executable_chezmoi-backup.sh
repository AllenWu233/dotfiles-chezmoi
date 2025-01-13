#!/bin/env bash
chezmoi re-add
cd "$HOME/.local/share/chezmoi" || exit
git add .
git commit -m "Backup $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main
