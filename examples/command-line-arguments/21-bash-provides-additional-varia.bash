#!/bin/bash
# Bash provides additional variables:
#
# - `$BASHPID` - PID of current bash process (differs in subshells)
# - `${@:n:m}` - Slice of arguments starting at n, m elements
# - `${!#}`    - The last argument

echo "Last argument: ${!#}"
echo "Args 2-3: ${@:2:2}"
