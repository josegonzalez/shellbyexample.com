#!/bin/sh
# You often need just part of a file — the first few
# lines, the last few, or a specific range. Three tools
# cover these cases: `head`, `tail`, and `sed -n`.

cat >/tmp/sample.txt <<'EOF'
Line 1: Introduction
Line 2: Background
Line 3: Methods
Line 4: Results
Line 5: Discussion
Line 6: Conclusion
EOF

# head -n N prints the first N lines
echo "=== First 2 lines (head) ==="
head -n 2 /tmp/sample.txt

# tail -n N prints the last N lines
echo ""
echo "=== Last 2 lines (tail) ==="
tail -n 2 /tmp/sample.txt

# sed -n 'X,Yp' prints lines X through Y
# The -n flag suppresses default output, and p prints
# only the matched range.
echo ""
echo "=== Lines 3-5 (sed) ==="
sed -n '3,5p' /tmp/sample.txt
