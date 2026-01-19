#!/bin/bash
# Bash adds `DEBUG`, which runs before each command executes.
# `$BASH_COMMAND` contains the command about to run.

trap 'echo "TRACE: $BASH_COMMAND"' DEBUG

x=5
y=10
sum=$((x + y))

trap - DEBUG
echo "Tracing disabled, sum=$sum"
