#!/bin/sh
# Here-document to temp file:

tmpfile=$(mktemp)
cat >"$tmpfile" <<'EOF'
Line 1
Line 2
Line 3
EOF
echo "From heredoc temp file:"
cat "$tmpfile"
rm "$tmpfile"
