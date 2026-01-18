#!/bin/sh
# Shell provides powerful string manipulation through
# parameter expansion. These techniques work without
# calling external commands.
#
# String length with `${#var}`:

str="Hello, World!"
echo "String: '$str'"
echo "Length: ${#str}"
