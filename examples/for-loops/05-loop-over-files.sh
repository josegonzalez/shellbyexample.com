#!/bin/sh
# Glob patterns (like `*.txt`) expand to matching filenames,
# making it easy to loop over files in a directory.
#
# Common glob patterns:
#
# - `*.txt`: All .txt files in current directory
# - `*/tmp/*`: All files in /tmp
# - `data?.csv`: data1.csv, data2.csv, etc.
#
# Important: if no files match the pattern, the glob
# expands to the literal pattern string. The defensive
# check `[ -e "$file" ] || continue` skips non-existent
# entries, preventing errors when the glob matches nothing.

touch /tmp/file1.txt /tmp/file2.txt /tmp/file3.txt

echo "Simple file iteration:"
for file in /tmp/file1.txt /tmp/file2.txt /tmp/file3.txt; do
    echo "  found: $file"
done

echo ""
echo "Using a glob pattern:"
for file in /tmp/file*.txt; do
    echo "  found: $file"
done

echo ""
echo "Defensive pattern (handles no matches):"
for file in /tmp/nonexistent*.xyz; do
    [ -e "$file" ] || continue
    echo "  found: $file"
done
echo "  (no files matched, loop body never ran)"

rm /tmp/file1.txt /tmp/file2.txt /tmp/file3.txt
