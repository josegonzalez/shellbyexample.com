#!/bin/sh
# Environment variables are key-value pairs available
# to every program running on your system. They store
# configuration like your username, home directory, and
# current working directory.
#
# Access any environment variable by prefixing its name
# with `$`. The shell replaces `$VARNAME` with the
# variable's value before running the command.

echo "Your username: $USER"
echo "Your home directory: $HOME"
echo "Current directory: $PWD"
