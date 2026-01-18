#!/bin/bash
# Bash provides extended test syntax `[[ ]]` which is
# safer and more powerful than single brackets `[ ]`.
#
# With `[[ ]]`, quoting is often optional:

name="Alice"
if [[ $name = Alice ]]; then
    echo "Hello, Alice!"
fi
