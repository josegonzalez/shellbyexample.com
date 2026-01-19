#!/bin/sh
# Command substitution can be used directly in strings
# by using the `$(command)` syntax.
#
# You can also use the backticks syntax, but `$()` is preferred
# as nesting does not require escaping.

echo "Current user: $(whoami)"
