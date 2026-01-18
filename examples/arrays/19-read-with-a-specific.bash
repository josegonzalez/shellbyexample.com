#!/bin/bash
# Read with a specific delimiter:

mapfile -t -d ':' fields <<<"a:b:c:d"
echo "Fields: ${fields[*]}"
