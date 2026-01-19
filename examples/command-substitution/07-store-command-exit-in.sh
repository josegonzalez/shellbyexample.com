#!/bin/sh
# Store command exit in a variable too if needed.

result="$(ls /nonexistent 2>&1)"
exit_code="$?"
echo "Result: $result"
echo "Exit code was: $exit_code"
