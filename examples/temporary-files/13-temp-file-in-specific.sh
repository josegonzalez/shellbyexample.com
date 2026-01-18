#!/bin/sh
# Temp file in specific directory:

# mktemp --tmpdir=/var/tmp myapp.XXXXXX  # GNU
# Or use template:
customtmp=$(mktemp /var/tmp/myapp.XXXXXX 2>/dev/null || mktemp)
echo "Custom location: $customtmp"
rm "$customtmp"
