#!/bin/sh
# Trap with signal number instead of name:

(
    trap 'echo "  Caught signal"' 2 # 2 = SIGINT
    echo "  Trap set for signal 2"
)
