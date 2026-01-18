#!/bin/bash
# Bash provides additional variables:
#
# - `${@:n:m}` - Slice of arguments starting at n, m elements
# - `${!#}`    - The last argument

echo "Last argument: ${!#}"
echo "Args 2-3: ${@:2:2}"
