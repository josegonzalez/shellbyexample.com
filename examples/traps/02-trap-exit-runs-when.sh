#!/bin/sh
# Trap `EXIT` runs when the script exits (any reason):

demo_exit_trap() {
    (
        trap 'echo "  Goodbye! Cleaning up..."' EXIT
        echo "  Working..."
        echo "  Done working"
    )
}

echo "EXIT trap demo:"
demo_exit_trap
