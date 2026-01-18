#!/bin/sh
# Execute command from string.
# Be careful with `eval` - avoid if possible.

cmd="echo 'Hello from eval'"
eval "$cmd"
