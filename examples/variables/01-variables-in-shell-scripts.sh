#!/bin/sh
# Variables in shell scripts store values that can
# be referenced later. Unlike many programming languages,
# shell variables don't require type declarations.
#
# To assign a variable, use `NAME=value` with no spaces
# around the `=` sign. This is important!
#
# To use a variable's value, prefix it with `$`.

greeting="Hello"
name="World"

echo "$greeting, $name!"
