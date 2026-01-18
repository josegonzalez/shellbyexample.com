#!/bin/sh
# Command substitution in conditionals:

if [ "$(echo hello)" = "hello" ]; then
  echo "Command output matches"
fi
