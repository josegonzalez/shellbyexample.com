#!/bin/sh
# Always quote variables in tests to handle empty
# values and spaces correctly.

user_input=""
if [ "$user_input" = "" ]; then
    echo "No input provided"
fi
