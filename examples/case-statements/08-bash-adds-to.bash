#!/bin/bash
# Bash adds `;;&` to fall through to test next pattern
# and `;&` to fall through unconditionally:

grade="B"
case "$grade" in
    A) echo "Excellent" ;;&
    A|B) echo "Good" ;;&
    A|B|C) echo "Passed" ;;
    *) echo "Failed" ;;
esac
