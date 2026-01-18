#!/bin/sh
# Trim whitespace:

padded="   hello world   "
echo "Padded: '$padded'"

# Using sed:
trimmed=$(echo "$padded" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
echo "Trimmed: '$trimmed'"
