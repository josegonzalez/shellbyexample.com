#!/bin/sh
# Always quote variables in tests to handle empty
# values and spaces correctly.

user_input=""
# this will be a syntax error if the variable is not quoted
if [ $user_input = "some_value" ]; then
    echo "No input provided"
fi
