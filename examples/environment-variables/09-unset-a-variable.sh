#!/bin/sh
# Unset a variable:

export TEMP_VAR="temporary"
echo "Before unset: $TEMP_VAR"
unset TEMP_VAR
echo "After unset: ${TEMP_VAR:-<unset>}"
