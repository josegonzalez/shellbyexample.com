#!/bin/sh
# Parameter expansion alternatives (faster, no subshell):

file="/path/to/document.tar.gz"
echo "Parameter expansion:"
echo "  Directory: ${file%/*}"   # Remove last /...
echo "  Filename: ${file##*/}"   # Remove through last /
echo "  Extension: ${file##*.}"  # Remove through last .
echo "  Without ext: ${file%.*}" # Remove last .xxx
echo "  Base name: ${file##*/}"
echo "  Base without ext: $(basename "${file%.*}")"
