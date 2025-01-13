#!/bin/bash
URL=https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt

curl "${URL}" | grep -v "^$" >urls.txt
while read -r line; do
	transmission-edit -a "${line}" "$1"
done <"urls.txt"
