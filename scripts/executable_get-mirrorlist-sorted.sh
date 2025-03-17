#!/bin/bash
mv /etc/pacman.d/mirrorlist{,.bak}

if [ ! $? -eq 0 ]; then
	echo "Failed! Try to use 'sudo' prefix."
	exit 1
fi

curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - >/etc/pacman.d/mirrorlist

echo "Done!"
bat /etc/pacman.d/mirrorlist
