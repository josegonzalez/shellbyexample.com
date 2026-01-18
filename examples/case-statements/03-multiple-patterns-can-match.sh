#!/bin/sh
# Multiple patterns can match the same block using `|`:

day="Saturday"

case "$day" in
    Monday | Tuesday | Wednesday | Thursday | Friday)
        echo "$day is a weekday"
        ;;
    Saturday | Sunday)
        echo "$day is a weekend day"
        ;;
    *)
        echo "Invalid day"
        ;;
esac
