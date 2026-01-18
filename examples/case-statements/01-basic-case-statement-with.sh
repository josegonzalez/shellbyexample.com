#!/bin/sh
# The `case` statement provides multi-way branching,
# similar to switch statements in other languages.
# It matches a value against patterns.
# This example shows a basic case statement with simple patterns.
#
# The `;;` terminates each case block.
# The `)` follows each pattern.

fruit="apple"

case "$fruit" in
apple)
  echo "It's an apple"
  ;;
banana)
  echo "It's a banana"
  ;;
cherry)
  echo "It's a cherry"
  ;;
esac
