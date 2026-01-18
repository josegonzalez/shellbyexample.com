#!/bin/sh
# Commands in a subshell with ():

echo "Subshell demo:"
(
  cd /tmp
  echo "  In subshell: $(pwd)"
  x="subshell_value"
)
echo "  After subshell: $(pwd)"
echo "  x is: ${x:-unset}"
