#!/bin/sh
# The `${var:?message}` syntax exits with an error if the
# variable is unset or empty. This provides a concise way
# to require arguments without writing explicit if-statements.
#
# The `:` (colon) command discards the expansion's value since
# we only want the side effect of triggering the error.

require_args() {
    : "${1:?Error: First argument (source file) is required}"
    : "${2:?Error: Second argument (destination) is required}"
    echo "Source: $1"
    echo "Destination: $2"
}

# This call succeeds
echo "With both arguments:"
require_args "input.txt" "output.txt"

# Uncommenting the line below would print an error and exit:
# require_args "only_one"
#
# Output would be:
# script: line N: 1: Error: First argument (source file) is required
