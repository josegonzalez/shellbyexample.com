#!/bin/sh
# Check if path is absolute:

is_absolute() {
    case "$1" in
        /*) return 0 ;;
        *) return 1 ;;
    esac
}

is_absolute "/home/user" && echo "/home/user is absolute"
is_absolute "relative/path" || echo "relative/path is relative"
