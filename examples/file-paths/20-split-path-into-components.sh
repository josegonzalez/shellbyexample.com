#!/bin/sh
# Split path into components:

echo "Path components:"
path="/usr/local/bin/script"
echo "$path" | tr '/' '\n' | while read -r component; do
    [ -n "$component" ] && echo "  $component"
done
