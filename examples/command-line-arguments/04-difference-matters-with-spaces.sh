#!/bin/sh
# Quoting matters when arguments contain spaces. Always use
# `"$@"` (quoted) to preserve argument boundaries. Unquoted
# `$@` or `$*` will break arguments that contain spaces into
# multiple separate arguments.

show_args() {
    echo "Received $# arguments:"
    for arg in "$@"; do
        echo "  '$arg'"
    done
}

set -- "hello world" "foo bar"

echo "With quoted \"\$@\" (correct):"
show_args "$@"

echo ""
echo "With quoted \"\$*\" (becomes one argument):"
# shellcheck disable=SC2066
for arg in "$*"; do
    echo "  [$arg]"
done

echo ""
echo "With unquoted \$@ (breaks on spaces - wrong):"
# shellcheck disable=SC2068
show_args $@

echo ""
echo "Rule: Always use \"\$@\" when passing arguments."
