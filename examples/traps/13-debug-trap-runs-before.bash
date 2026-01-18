#!/bin/bash
# `DEBUG` trap runs before each command:

demo_debug_trap() {
    (
        trap 'echo "  DEBUG: $BASH_COMMAND"' DEBUG
        x=5
        y=10
        echo "  Sum: $((x + y))"
    )
}

echo "DEBUG trap demo:"
demo_debug_trap
