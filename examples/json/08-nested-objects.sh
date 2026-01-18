#!/bin/sh
# Nested objects:

nested='{"user":{"name":"Bob","address":{"city":"LA","zip":"90001"}}}'
echo "Nested access:"
echo "$nested" | jq '.user.address.city'
