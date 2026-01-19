#!/bin/sh
# Reading lines safely requires two techniques:
#
# - `IFS=` prevents trimming leading/trailing whitespace
# - `-r` prevents backslash interpretation
#
# The `|| [ -n "$line" ]` handles files that don't end with
# a newline - without it, the last line would be skipped.
#
# Note: This example uses a here-document (`<<'EOF'`) to
# provide input. Here-documents are covered in a later section.

while IFS= read -r line || [ -n "$line" ]; do
    echo "Line: '$line'"
done <<'EOF'
  indented line
line with trailing space
normal line
EOF
