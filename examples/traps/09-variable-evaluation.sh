#!/bin/sh
# Variables in traps are evaluated when the trap runs, not when
# it's defined. Use single quotes to get this delayed evaluation.

value="initial"
trap 'echo "At exit: $value"' EXIT
value="changed"

echo "Value is now: $value"
