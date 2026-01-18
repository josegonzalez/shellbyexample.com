#!/bin/sh
# Environment variables are key-value pairs that
# configure how programs behave. They're inherited
# by child processes.
#
# Access environment variables with `$` prefix:

echo "Current user: $USER"
echo "Home directory: $HOME"
echo "Current shell: $SHELL"
echo "Current path: $PATH"
