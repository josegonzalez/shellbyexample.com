#!/bin/sh
# Change extension:

change_extension() {
    echo "${1%.*}.$2"
}

echo "Change ext: $(change_extension "file.txt" "md")"
