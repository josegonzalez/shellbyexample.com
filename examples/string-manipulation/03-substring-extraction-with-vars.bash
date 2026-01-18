#!/bin/bash
# Substring extraction with ${var:start:length}:
# Note: This is bash-specific, not POSIX sh

text="Hello, World!"
echo "First 5 chars: ${text:0:5}"
echo "From position 7: ${text:7}"
echo "Last 6 chars: ${text: -6}"  # Note the space before -
