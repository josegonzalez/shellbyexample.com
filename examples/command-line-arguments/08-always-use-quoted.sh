#!/bin/sh
# Always use `"$@"` (quoted) to preserve argument boundaries.
# Unquoted `$@` or `$*` breaks arguments containing spaces.

show_args() {
    echo "Received $# arguments:"
    for arg in "$@"; do
        echo "  '$arg'"
    done
}

# Simulating: script called with "hello world" "foo"
set -- "hello world" "foo"

echo "With quoted \"\$@\":"
show_args "$@"

echo ""
echo "With unquoted \$@:"
show_args $@
