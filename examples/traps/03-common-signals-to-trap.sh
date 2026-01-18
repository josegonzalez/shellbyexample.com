#!/bin/sh
# Common signals to trap:
#
# - `EXIT` (0)   - Script exit (success or failure)
# - `INT` (2)    - Interrupt (Ctrl+C)
# - `TERM` (15)  - Termination request
# - `HUP` (1)    - Hangup
# - `ERR`        - On error (bash only)

demo_exit_success() {
    (
        trap 'echo "  EXIT trap (success)"' EXIT
        echo "  Exiting normally..."
    )
}

demo_exit_failure() {
    (
        trap 'echo "  EXIT trap (failure)"' EXIT
        echo "  About to fail..."
        exit 1
    )
}

echo "EXIT runs on success:"
demo_exit_success

echo "EXIT runs on failure too:"
demo_exit_failure
