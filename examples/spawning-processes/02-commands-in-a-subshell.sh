#!/bin/sh
# Commands in a subshell with `()`. Commands are executed in a subshell,
# so the changes to the environment are not reflected in the parent shell.

echo "Subshell demo:"
(
  cd /tmp
  echo "  In subshell: $(pwd)"
  x="subshell_value"
)
echo "  After subshell: $(pwd)"
echo "  x is: ${x:-unset}"
