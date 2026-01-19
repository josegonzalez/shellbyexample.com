#!/bin/sh
# Use `|` to match multiple patterns with the same action.
# This is useful when several values should behave the same.

day="saturday"

case $day in
    monday | tuesday | wednesday | thursday | friday)
        echo "It's a weekday"
        ;;
    saturday | sunday)
        echo "It's a weekend"
        ;;
esac
