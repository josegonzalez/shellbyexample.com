#!/bin/sh
# Check if it's exported by running a subshell:

sh -c 'echo "In child - MY_VAR: ${MY_VAR:-<unset>}"'
sh -c 'echo "In child - MY_EXPORTED: ${MY_EXPORTED:-<unset>}"'
