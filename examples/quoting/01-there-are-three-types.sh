#!/bin/sh
# Quoting in shell scripts controls how special
# characters are interpreted. Understanding quoting
# is essential for writing correct shell scripts.
#
# There are three types of quoting: single quotes,
# double quotes, and backslash escaping.
#
# Double quotes preserve most characters literally
# but allow variable expansion and some escapes.
#
# Single quotes preserve ALL characters literally.
# No variable expansion happens inside single quotes.

name="World"

echo "Hello, $name!"
echo 'Hello, $name!'
echo "Hello, \$name!"
