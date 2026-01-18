#!/bin/sh
# Get file extension:

get_extension() {
    filename="$1"
    case "$filename" in
        *.*) echo "${filename##*.}" ;;
        *)   echo "" ;;
    esac
}

echo "Extension of file.txt: $(get_extension "file.txt")"
echo "Extension of archive.tar.gz: $(get_extension "archive.tar.gz")"
echo "Extension of noext: $(get_extension "noext")"
