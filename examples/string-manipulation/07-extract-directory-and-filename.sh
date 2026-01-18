#!/bin/sh
# Extract directory and filename using parameter expansion.

path="/usr/local/bin/script.sh"
echo "Path: $path"
echo "Directory: ${path%/*}"
echo "Filename: ${path##*/}"
echo "Basename without ext: $(basename "${path%.*}")"
