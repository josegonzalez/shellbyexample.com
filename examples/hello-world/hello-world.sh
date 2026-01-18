#!/bin/sh

: # Our first shell script is the classic "Hello World".
: # This example demonstrates the basic structure of a
: # shell script.

echo "Hello, World!"

: # You can run this script by saving it to a file
: # (e.g., `hello-world.sh`), making it executable
: # with `chmod +x hello-world.sh`, and then running
: # it with `./hello-world.sh`.

: # The `echo` command prints text to standard output.
: # It's one of the most commonly used commands in
: # shell scripting.

echo "Welcome to Shell by Example!"

: # You can also print multiple lines using multiple
: # echo commands, or use special characters.

echo "Line 1"
echo "Line 2"

: # The `-n` flag prevents echo from adding a newline
: # at the end of the output.

echo -n "No newline after this"
echo " - continues on same line"
