#!/bin/bash
# Bash provides `ERR` trap for errors.
# This runs on any command failure.

set -e
trap 'echo "Error on line $LINENO"' ERR
false
