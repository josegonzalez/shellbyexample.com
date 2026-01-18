#!/bin/sh
# Command substitution in conditionals:

# shellcheck disable=SC2116
if [ "$(echo "hello")" = "hello" ]; then
  echo "Command output matches"
fi
