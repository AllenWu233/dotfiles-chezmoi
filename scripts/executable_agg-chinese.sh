#!/bin/bash
# Add space after every Chinese character to fit agg
# Usage: agg-chinese.sh demo.cast demo.space.cast
cat "$1" | perl -CS -pe 's/([\x{4e00}-\x{9fa5}]|[\x{3040}-\x{30ff}])/$1 /g' >"$2"
