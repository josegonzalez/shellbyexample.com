#!/bin/sh
# Arithmetic:

echo "Arithmetic:"
echo '{"a":10,"b":3}' | jq '.a + .b'
echo '{"a":10,"b":3}' | jq '.a * .b'
echo '{"a":10,"b":3}' | jq '.a / .b'
