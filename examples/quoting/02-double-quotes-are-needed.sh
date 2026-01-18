#!/bin/sh
# Double quotes are needed when strings contain variables
# that need to be expanded or special characters you may want to escape.
#
# A good use case is when you want to have double quotes in a string
# as well as variable expansion.
#
# You can embed double quotes in doubly quoted strings
# by escaping the double quote with a backslash.
#
# Please also note the difference between echo and printf.

variable="world"
echo "Hello, $variable!"
# example with special characters
echo "Hello, \"$variable\"!"
# shellcheck disable=SC2028
echo "Backslashes are literal here as well: \n \t more content after the escape sequences"
# echo may not expand escape sequences, so if you need it, use printf.
printf "Backslashes are literal here as well: \n \t more content after the escape sequences\n"
# shellcheck disable=SC2028
echo "Multiple backslashes (2): \\\\"
echo "Escaped double quote: \""
