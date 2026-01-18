#!/bin/sh
# Temp file in specific directory using a template

customtmp=$(mktemp /tmp/myapp.XXXXXX)
echo "Custom location: $customtmp"
rm "$customtmp"
