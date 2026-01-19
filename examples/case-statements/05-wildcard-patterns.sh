#!/bin/sh
# Case patterns support glob-style wildcards.
# Use `*` to match any string of characters.
# This is powerful for matching prefixes or suffixes.

file="script.sh"

case $file in
    *.sh)
        echo "$file is a shell script"
        ;;
    *.txt)
        echo "$file is a text file"
        ;;
    test*)
        echo "$file starts with 'test'"
        ;;
    *)
        echo "$file has unknown type"
        ;;
esac
