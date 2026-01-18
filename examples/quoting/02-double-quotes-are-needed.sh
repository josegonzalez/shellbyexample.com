#!/bin/sh
# Double quotes are needed when strings contain variables
# that need to be expanded or special characters you may want to escape.
#
# A good use case is when you want to have double quotes in a string
# as well as variable expansion.
#
# You can embed double quotes in doubly quoted strings
# by escaping the double quote with a backslash.

variable="world"
echo "Hello, $variable!"
# example with special characters
echo "Hello, \"$variable\"!"
echo "Backslashes are literal here as well: \n \t"
echo "Multiple backslashes (2): \\\\"
echo "Escaped double quote: \""
