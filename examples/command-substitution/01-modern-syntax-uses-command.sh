#!/bin/sh
# Command substitution lets you capture the output
# of a command and use it as a value. This is one
# of the most powerful features in shell scripting.
#
# The modern syntax uses `$(command)`.

current_user=$(whoami)
echo "Current user: $current_user"
