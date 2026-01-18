#!/bin/sh
# Find common prefix of paths:

common_prefix() {
    printf '%s\n%s\n' "$1" "$2" | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/'
}

echo "Common prefix:"
echo "  $(common_prefix "/home/user/docs" "/home/user/pics")"
