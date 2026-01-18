#!/bin/sh
# Process multiple JSON objects (jsonl):

echo "JSONL processing:"
printf '{"id":1}\n{"id":2}\n{"id":3}\n' | jq -c '.id *= 10'
