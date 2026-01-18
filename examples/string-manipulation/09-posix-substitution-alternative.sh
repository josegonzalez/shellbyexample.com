#!/bin/sh
# POSIX substitution alternatives:

msg="hello world world"
echo "POSIX substitution with sed:"
echo "  Replace first: $(echo "$msg" | sed 's/world/universe/')"
echo "  Replace all: $(echo "$msg" | sed 's/world/universe/g')"
