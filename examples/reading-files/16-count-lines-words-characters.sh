#!/bin/sh
# Count lines, words, characters:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "File statistics:"
# shellcheck disable=SC2034
wc /tmp/sample.txt | while read -r lines words chars filename; do
  echo "  Lines: $lines"
  echo "  Words: $words"
  echo "  Chars: $chars"
done
