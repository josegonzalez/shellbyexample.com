#!/bin/sh
# Note: Variables set in piped while loops don't persist
# outside due to subshell. Use a different approach:

echo "Sum with here-string (persists):"
total=0
while read -r n; do
  total=$((total + n))
done <<'EOF'
10
20
30
EOF
echo "Total: $total"
