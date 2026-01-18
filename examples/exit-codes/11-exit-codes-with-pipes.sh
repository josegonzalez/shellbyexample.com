#!/bin/sh
# Exit codes with pipes - `$?` gives last command's code:

echo "hello" | grep -q "world"
echo "Pipe exit code: $?"
