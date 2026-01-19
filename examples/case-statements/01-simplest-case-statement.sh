#!/bin/sh
# A `case` statement matches a value against patterns.
# It's the shell's equivalent to a switch statement.
#
# Syntax breakdown:
#
# - `case VALUE in` starts the statement
# - `pattern)` defines a pattern to match (note the `)`)
# - `;;` ends each pattern block (like `break`)
# - `esac` ends the statement (`case` spelled backward)

fruit="apple"

case $fruit in
    apple)
        echo "It's an apple"
        ;;
esac
