#!/bin/sh
# Use `<< 'EOF'` (quoted) to prevent variable expansion.

cat << 'EOF'
This text is literal.
$HOME is not expanded here.
Special characters like \n are also literal.
EOF
