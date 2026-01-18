#!/bin/sh
# Use `env` to run command with modified environment:

env MYVAR=test sh -c 'echo "MYVAR=$MYVAR"'
