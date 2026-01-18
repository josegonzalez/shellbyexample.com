#!/bin/sh
# Functions must be defined before they're called.
# Unlike some languages, shell scripts are interpreted
# top-to-bottom, so calling an undefined function fails.

# Calling an undefined function produces an error:
undefined_func 2>&1 || true

# This works: define first, then call
greet() {
    echo "Hello, $1!"
}
greet "World"
