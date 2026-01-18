#!/bin/sh
# Quoting in shell scripts controls how special
# characters are interpreted. Understanding quoting
# is essential for writing correct shell scripts.
#
# There are three types of quoting: single quotes,
# double quotes, and backslash escaping.
#
# Single quotes can be used if there are no variables to expand
# or if there are no special characters you need to escape.
#
# Use single quotes when you want literal text with
# no interpretation of special characters.
#
# You can embed single quotes in singly quoted strings
# by enclosing the escaped single quote with single quotes.

# shellcheck disable=SC2034
variable="world"
echo 'Hello, world!'
# shellcheck disable=SC2016
echo 'Hello, $name!'
# shellcheck disable=SC2028
echo 'Backslashes are literal: \n \t'
# shellcheck disable=SC2028
# shellcheck disable=SC1003
echo 'Multiple backslashes (4): \\\\'
echo 'Escaped single quote: '\'''
