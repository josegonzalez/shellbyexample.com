#!/bin/sh
# Basic case statement with simple patterns:
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
