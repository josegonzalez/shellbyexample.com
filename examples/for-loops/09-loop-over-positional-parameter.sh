#!/bin/sh
# Loop over positional parameters:

set -- first second third
for arg in "$@"; do
    echo "Argument: $arg"
done
