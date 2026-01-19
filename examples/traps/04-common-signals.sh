#!/bin/sh
# Common signals
#
# - `EXIT` (script end)
# - `INT` (Ctrl+C)
# - `TERM` (kill)
# - `HUP` (terminal close).

# EXIT runs when script ends
echo "EXIT signal:"
(
    trap 'echo "  EXIT signal caught"' EXIT
    echo "  Trap set for EXIT"
)

echo ""

# INT catches Ctrl+C
echo "INT signal (Ctrl+C):"
(
    trap 'echo "  INT signal caught"' INT
    echo "  Trap set for Ctrl+C, won't run as script ends normally"
)

echo ""

# TERM catches kill command
echo "TERM signal (kill):"
(
    trap 'echo "  TERM signal caught"' TERM
    echo "  Trap set for TERM, won't run as script ends normally"
)
