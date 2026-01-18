#!/bin/sh

: # Quoting in shell scripts controls how special
: # characters are interpreted. Understanding quoting
: # is essential for writing correct shell scripts.

: # There are three types of quoting: single quotes,
: # double quotes, and backslash escaping.

name="World"

: # Double quotes preserve most characters literally
: # but allow variable expansion and some escapes.

echo "Hello, $name!"

: # Single quotes preserve ALL characters literally.
: # No variable expansion happens inside single quotes.

echo 'Hello, $name!'

: # Use single quotes when you want literal text with
: # no interpretation of special characters.

echo 'The variable is written as $name'
echo 'Backslashes are literal: \n \t'

: # Double quotes are needed when variables might
: # contain spaces or special characters.

filename="my file.txt"
echo "Processing: $filename"

: # Without quotes, the shell would split on spaces.
: # This is called word splitting.

: # The backslash escapes single characters.

echo "She said \"Hello\""
echo "Path: C:\\Users\\name"
echo "Dollar sign: \$100"

: # You can mix quoting styles in the same string.

echo "It's a $name"
echo 'Say "Hello"'

: # Some useful escape sequences in double quotes:

echo "Line 1\nLine 2"   # Note: \n is NOT interpreted here (use echo -e or $'...')
echo "Tab:\tseparated"  # Note: \t is NOT interpreted here (use echo -e or $'...')

: # For reliable newlines, use $'...' syntax (POSIX)
: # or literal newlines.

echo "Line 1
Line 2"
