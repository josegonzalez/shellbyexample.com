#!/bin/sh
# The `trap` command lets you catch signals and
# execute cleanup code when your script exits or
# receives signals. It's essential for robust scripts.
#
# Basic trap syntax: `trap 'commands' SIGNAL`

basic_trap() {
    (
        trap 'echo "  Trap triggered!"' EXIT
        echo "  Script is running..."
    )
}

echo "Basic trap demo:"
basic_trap
