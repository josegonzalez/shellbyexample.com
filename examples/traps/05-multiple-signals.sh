#!/bin/sh
# You can trap multiple signals with the same handler by listing
# them after the command.

trap 'echo "  Signal caught - cleaning up..."' INT TERM

echo "Same handler for INT and TERM"
echo "Exiting normally (neither signal sent)"
