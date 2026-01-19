#!/bin/sh
# The `trap` command runs code when your script receives a signal.
# Syntax: trap 'commands' SIGNAL
#
# The most common signal is EXIT, which fires when the script ends
# for any reason - normal completion, error, or interrupt.

trap 'echo "Goodbye!"' EXIT

echo "Script is running..."
echo "About to exit..."
