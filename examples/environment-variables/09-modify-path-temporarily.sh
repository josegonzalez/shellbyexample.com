#!/bin/sh
# Modify PATH temporarily:

echo "Original PATH has $(echo "$PATH" | tr ':' '\n' | wc -l | tr -d ' ') entries"

PATH="$HOME/bin:$PATH"
echo "After prepending \$HOME/bin: PATH starts with ${PATH%%:*}"
