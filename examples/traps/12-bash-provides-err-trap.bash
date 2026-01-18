#!/bin/bash
# Bash provides `ERR` trap for errors:

set -e
trap 'echo "Error on line $LINENO"' ERR
This runs on any command failure
