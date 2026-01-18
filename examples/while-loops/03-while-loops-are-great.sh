#!/bin/sh
# While loops are great for reading files line by line.
# The `IFS=` prevents leading/trailing whitespace trimming.
# The `-r` flag prevents backslash interpretation.

echo "Reading lines:"
while IFS= read -r line; do
    echo "  -> $line"
done <<'EOF'
First line
Second line
Third line
EOF
