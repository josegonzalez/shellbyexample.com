#!/bin/sh
# Empty patterns are allowed (do nothing):

value="skip"

case "$value" in
  skip)
    # Do nothing
    ;;
  process)
    echo "Processing..."
    ;;
esac

echo "Done"
