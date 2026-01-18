#!/bin/sh
# Use `*` as a default/catch-all pattern:

color="purple"

case "$color" in
  red)
    echo "Color is red"
    ;;
  blue)
    echo "Color is blue"
    ;;
  *)
    echo "Unknown color: $color"
    ;;
esac
