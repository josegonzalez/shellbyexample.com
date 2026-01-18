#!/bin/sh
# Functions let you group commands together and
# reuse them throughout your script. They're
# essential for organizing larger scripts.
#
# Define a function using the `name() { }` syntax.
# The `function` keyword is optional and not POSIX.

greet() {
    echo "Hello, World!"
}
