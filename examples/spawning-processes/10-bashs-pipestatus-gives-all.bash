#!/bin/bash
# Bash provides a `PIPESTATUS` array for all pipe exit codes:

echo "test" | false | true
echo "PIPESTATUS: ${PIPESTATUS[*]}"
