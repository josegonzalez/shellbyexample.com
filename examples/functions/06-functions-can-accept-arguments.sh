#!/bin/sh
# Functions can accept arguments via `$1`, `$2`, etc.

greet_user() {
    echo "Hello, $1!"
}

greet_user "Alice"
greet_user "Bob"
