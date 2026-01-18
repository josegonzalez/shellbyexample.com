#!/bin/sh
# Character class patterns work too:

char="5"

case "$char" in
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
