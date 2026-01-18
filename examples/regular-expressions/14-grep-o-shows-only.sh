#!/bin/sh
# grep -o shows only matching part:

echo "Extract email addresses:"
grep -oE "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" /tmp/sample.txt
