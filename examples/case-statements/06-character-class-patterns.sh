#!/bin/sh
# Character classes `[...]` match any single character
# in the set. Common classes include:
# - `[0-9]` for digits
# - `[a-z]` for lowercase letters
# - `[A-Z]` for uppercase letters
# - `[abc]` for specific characters

char="7"

case $char in
    [0-9])
        echo "'$char' is a digit"
        ;;
    [a-z])
        echo "'$char' is a lowercase letter"
        ;;
    [A-Z])
        echo "'$char' is an uppercase letter"
        ;;
    *)
        echo "'$char' is something else"
        ;;
esac
