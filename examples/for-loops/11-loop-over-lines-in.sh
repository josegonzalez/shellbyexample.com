#!/bin/sh
# Loop over lines in a file (safer than for loop):

echo "Reading lines:"
while IFS= read -r line || [ -n "$line" ]; do
    echo "  Line: $line"
done << 'EOF'
First line
Second line
Third line
EOF
