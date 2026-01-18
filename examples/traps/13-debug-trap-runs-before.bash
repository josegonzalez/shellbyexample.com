#!/bin/bash
# `DEBUG` trap runs before each command:

trap 'echo "Running: $BASH_COMMAND"' DEBUG
