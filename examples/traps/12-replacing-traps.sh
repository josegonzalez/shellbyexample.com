#!/bin/sh
# Setting a new trap replaces the previous one for that signal.
# Only one trap handler can be active per signal.

trap 'echo "First handler"' EXIT
echo "First trap set"

trap 'echo "Second handler"' EXIT
echo "Second trap set (replaces first)"
