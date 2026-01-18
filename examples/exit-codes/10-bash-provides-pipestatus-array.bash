#!/bin/bash
# Bash provides a `PIPESTATUS` array for all pipe exit codes:

cat /nonexistent 2>/dev/null | grep "pattern" | head -n 1
echo "First command: ${PIPESTATUS[0]}"
echo "Second command: ${PIPESTATUS[1]}"
echo "Third command: ${PIPESTATUS[2]}"
