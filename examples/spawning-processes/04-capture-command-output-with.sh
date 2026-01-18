#!/bin/sh
# Capture command output with $():

files=$(ls -1 /tmp | head -3)
echo "Captured output:"
echo "$files"
