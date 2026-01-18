#!/bin/sh
# String operations:

echo "String operations:"
echo '{"msg":"hello world"}' | jq '.msg | ascii_upcase'
echo '{"msg":"hello world"}' | jq '.msg | split(" ")'
echo '{"msg":"hello world"}' | jq '.msg | length'
