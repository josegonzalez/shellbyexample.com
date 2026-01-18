#!/bin/sh
# Export makes variables available to child processes.
# You can set and export in one line.

export MY_VAR="hello"
export GREETING="Hello, World!"

echo "MY_VAR: $MY_VAR"
echo "GREETING: $GREETING"
