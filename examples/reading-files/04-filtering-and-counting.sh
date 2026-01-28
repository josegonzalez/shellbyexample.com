#!/bin/sh
# When files are large, you rarely want to read
# everything. `grep` searches for matching lines and
# `wc` counts lines, words, and characters — letting
# you inspect a file without reading it all.

cat >/tmp/log.txt <<'EOF'
INFO  Server started
ERROR Cannot connect to database
INFO  Request received from 10.0.0.1
WARN  Slow query detected (3.2s)
ERROR Timeout waiting for response
INFO  Request completed
EOF

# grep prints lines matching a pattern
echo "=== Errors only (grep) ==="
grep "ERROR" /tmp/log.txt

# grep -c counts matches instead of printing them
echo ""
echo "=== Error count ==="
echo "$(grep -c "ERROR" /tmp/log.txt) errors found"

# wc gives line, word, and byte counts
echo ""
echo "=== File statistics (wc) ==="
lines=$(wc -l </tmp/log.txt)
words=$(wc -w </tmp/log.txt)
chars=$(wc -c </tmp/log.txt)
echo "Lines: $lines"
echo "Words: $words"
echo "Bytes: $chars"
