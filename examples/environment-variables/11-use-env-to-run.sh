#!/bin/sh
# Use `env` to run command with modified environment:

# shellcheck disable=SC2016
env MYVAR=test sh -c 'echo "MYVAR=$MYVAR"'
