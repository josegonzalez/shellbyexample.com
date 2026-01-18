#!/bin/sh
# Every command returns an exit code (0-255).
# By convention, 0 means success and non-zero
# indicates an error. The special variable `$?`
# holds the last command's exit code.
#
# Successful command returns 0:

true
echo "Exit code of 'true': $?"
