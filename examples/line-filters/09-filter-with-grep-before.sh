#!/bin/sh
# Filter with grep before processing:

cat >/tmp/data.txt <<'EOF'
apple 10 red
banana 20 yellow
cherry 15 red
date 25 brown
EOF

# shellcheck disable=SC2034
grep "red" /tmp/data.txt | while read -r fruit count color; do
  echo "  Red fruit: $fruit"
done
