#!/bin/sh
# Unlike `echo`, `printf` doesn't add a newline automatically.
# Use `\n` to add newlines.

printf "Line 0 without trailing newline"
printf "Line 1\n"
printf "Line 2\n"
