#!/bin/bash
# Bash provides noclobber option to prevent overwriting:

set -o noclobber
echo "test" > existingfile.txt  # Fails if file exists
echo "test" >| existingfile.txt  # Force overwrite
set +o noclobber
