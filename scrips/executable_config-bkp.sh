#!/bin/bash
# config-bkp - Backup dotfiles and configuration

home_dir="/home/Allen"
dotfiles_dir="/home/Allen/repo/dotfiles"
hledger_dir="/home/Allen/repo/hledger/"

"$dotfiles_dir"/backup.sh
"$hledger_dir"/backup.sh

log_path=/home/Allen/scrips/config-bkp.log
date '+%Y-%m-%d %H:%M:%S' | tee -a "$log_path"
printf "Configuration backup finished!\n" | tee -a "$log_path"
