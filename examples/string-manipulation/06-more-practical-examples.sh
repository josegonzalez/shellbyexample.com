#!/bin/sh
# More practical examples using parameter expansion.

filename="document.backup.tar.gz"
echo "Filename: $filename"
echo "Remove .gz: ${filename%.gz}"
echo "Remove all extensions: ${filename%%.*}"
echo "Get extension: ${filename##*.}"
