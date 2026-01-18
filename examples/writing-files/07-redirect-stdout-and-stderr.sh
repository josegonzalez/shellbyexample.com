#!/bin/sh
# Redirect stdout and stderr:

echo "Redirect stdout (1) and stderr (2):"

# Stdout only to file
ls /tmp >/tmp/stdout.txt 2>/dev/null

# Stderr only to file
ls /nonexistent 2>/tmp/stderr.txt

# Both to same file
ls /tmp /nonexistent >/tmp/both.txt 2>&1

# Both to different files
ls /tmp /nonexistent >/tmp/out.txt 2>/tmp/err.txt

echo "  Stderr captured: $(cat /tmp/stderr.txt)"
