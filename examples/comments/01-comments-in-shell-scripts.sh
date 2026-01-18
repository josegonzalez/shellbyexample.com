#!/bin/sh
# Comments in shell scripts start with the `#` character.
# Everything after `#` on a line is ignored by the shell.
#
# Comments are essential for documenting your scripts.
# They help others (and future you) understand what
# the code does.
#
# You can use comments to:
#
# - Explain complex logic
# - Document function purposes
# - Leave TODO notes
# - Temporarily disable code
#
# Multi-line comments don't have special syntax.
# You simply start each line with `#`.

echo "This line runs" # This comment is ignored

# TODO: Implement this feature
awesome_feature() {
    true
}

# broken_function

# multi-line comment
# another line

# Note: There's no block comment syntax in shell.
# Some people use here-documents for multi-line
# comments, but that's a hack - just use `#`.
