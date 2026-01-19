#!/bin/sh
# A `case` statement can have multiple pattern blocks.
# The shell tests each pattern in order and executes
# the first matching block.

color="blue"

case $color in
    red)
        echo "Color is red"
        ;;
    green)
        echo "Color is green"
        ;;
    blue)
        echo "Color is blue"
        ;;
esac
