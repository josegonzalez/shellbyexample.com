#!/bin/sh
# Commands in a subshell with `()`. Commands are executed in a subshell,
# so the changes to the environment are not reflected in the parent shell.

echo "Subshell demo:"
(
  cd /tmp || exit 1
  echo "  In subshell: $(pwd)"
  # shellcheck disable=SC2030
  x="subshell_value"
)
echo "  After subshell: $(pwd)"
# shellcheck disable=SC2031
echo "  x is: ${x:-unset}"
