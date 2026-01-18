#!/bin/bash
# Substring extraction with `${var:start:length}`.

text="Hello, World!"
echo "First 5 chars: ${text:0:5}"
echo "From position 7: ${text:7}"
echo "Last 6 chars: ${text: -6}" # Note the space before -
