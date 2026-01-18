#!/bin/sh
# Capture the contents of a file.

echo "this is a test" >/tmp/test.txt
echo "Config: $(cat /tmp/test.txt)"
