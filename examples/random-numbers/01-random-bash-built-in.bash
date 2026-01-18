#!/bin/bash
# Random numbers can be generated using the `$RANDOM` variable.
# This is not cryptographically secure, but it is fast and easy to use.
# To generate a cryptographically secure random number, use `/dev/urandom`.
#
# $RANDOM - Bash built-in (0 to 32767):

echo "Bash \$RANDOM: $RANDOM"
echo "Another: $RANDOM"
echo "Range 1-100: $((RANDOM % 100 + 1))"
