#!/bin/sh
# Patterns support glob-style wildcards:

filename="script.sh"

case "$filename" in
    *.sh)
        echo "Shell script"
        ;;
    *.py)
        echo "Python script"
        ;;
    *.txt)
        echo "Text file"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac
