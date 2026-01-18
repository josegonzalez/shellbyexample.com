#!/bin/sh
# Command substitution can be nested with `$()` syntax.

echo "Today is $(date +%A), week $(date +%V)"
