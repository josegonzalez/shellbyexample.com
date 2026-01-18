#!/bin/bash
# Bash's PIPESTATUS gives all exit codes:

echo "test" | false | true
echo "PIPESTATUS: ${PIPESTATUS[@]}"
