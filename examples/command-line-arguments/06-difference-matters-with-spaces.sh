#!/bin/sh
# The difference matters with spaces in arguments.
# Always use `"$@"` (quoted) to preserve argument boundaries.
# Unquoted `$@` or `$*` breaks arguments containing spaces.

show_args() {
  echo "Received $# arguments:"
  for arg in "$@"; do
    echo "  '$arg'"
  done
}

set -- "hello world" "foo bar"

echo "With quoted \"\$@\":"
show_args "$@"

echo ""
echo "With quoted \"\$*\":"
# shellcheck disable=SC2066
for arg in "$*"; do
  echo "  [$arg]"
done

echo ""
echo "With unquoted \$@ (breaks spaces):"
# shellcheck disable=SC2068
show_args $@
