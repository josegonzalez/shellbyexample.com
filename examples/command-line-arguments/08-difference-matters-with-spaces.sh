#!/bin/sh
# The difference matters with spaces in arguments:

set -- "hello world" "foo bar"
echo "With quoted \$@:"
for arg in "$@"; do
  echo "  [$arg]"
done

echo "With quoted \$*:"
for arg in "$*"; do
  echo "  [$arg]"
done
