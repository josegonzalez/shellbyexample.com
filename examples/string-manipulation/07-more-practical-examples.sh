#!/bin/sh
# More practical examples:

filename="document.backup.tar.gz"
echo "Filename: $filename"
echo "Remove .gz: ${filename%.gz}"
echo "Remove all extensions: ${filename%%.*}"
echo "Get extension: ${filename##*.}"
