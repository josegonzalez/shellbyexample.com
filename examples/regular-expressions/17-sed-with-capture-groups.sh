#!/bin/sh
# sed with capture groups:

echo "Capture groups (swap words):"
echo "foo bar" | sed 's/\(foo\) \(bar\)/\2 \1/'

# Extended regex with -E
echo "Extract domain from email:"
echo "user@example.com" | sed -E 's/.*@(.+)/\1/'
