#!/bin/sh
# Use `trap - SIGNAL` to reset a trap to default behavior.
# Use `trap '' SIGNAL` to ignore a signal entirely.

# Reset trap to default
echo "Reset trap:"
(
    trap 'echo "  Custom handler"' EXIT
    echo "  Custom trap set"
    trap - EXIT
    echo "  Trap reset (no output on exit)"
)

echo ""

# Ignore a signal with empty string
echo "Ignore signal:"
trap '' INT
echo "  Ctrl+C is now ignored"
trap - INT
echo "  Ctrl+C restored"
