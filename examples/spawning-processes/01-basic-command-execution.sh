#!/bin/sh
# Shell provides several ways to spawn and control
# processes. This covers subshells, command execution,
# and process management.
#
# This example shows how to run one command based on the output of another command.

touch /tmp/hello.txt /tmp/world.txt /tmp/hello_world.txt /tmp/hello_world_2.txt
find /tmp -maxdepth 1 -type f -exec ls {} + 2>/dev/null | head -3
