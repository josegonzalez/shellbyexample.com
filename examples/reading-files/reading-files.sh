#!/bin/sh

: # Shell provides several ways to read file contents.
: # This example covers common file reading patterns.

: # Create a sample file for demonstration:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

: # Read entire file with `cat`:

echo "Using cat:"
cat /tmp/sample.txt

: # Read file into a variable:

content=$(cat /tmp/sample.txt)
echo "File content in variable:"
echo "$content"

: # Read first N lines with `head`:

echo "First 2 lines (head):"
head -n 2 /tmp/sample.txt

: # Read last N lines with `tail`:

echo "Last 2 lines (tail):"
tail -n 2 /tmp/sample.txt

: # Read specific line range:

echo "Lines 2-4 (sed):"
sed -n '2,4p' /tmp/sample.txt

: # Read file line by line with while loop:

echo "Reading line by line:"
while IFS= read -r line; do
  echo "  -> $line"
done </tmp/sample.txt

: # IFS= prevents leading/trailing whitespace stripping.
: # -r prevents backslash interpretation.

: # Process lines with line numbers:

echo "With line numbers:"
n=1
while IFS= read -r line; do
  echo "  $n: $line"
  n=$((n + 1))
done </tmp/sample.txt

: # Read file and handle last line without newline:

printf "no newline" >/tmp/nolf.txt
echo "Reading file without final newline:"
while IFS= read -r line || [ -n "$line" ]; do
  echo "  [$line]"
done </tmp/nolf.txt
rm /tmp/nolf.txt

: # Read specific fields from each line:

cat >/tmp/data.txt <<'EOF'
alice:30:engineer
bob:25:designer
carol:35:manager
EOF

echo "Reading colon-separated fields:"
while IFS=: read -r name age job; do
  echo "  $name is a $age year old $job"
done </tmp/data.txt

: # Read file into array (bash-specific shown later):

: # Check if file exists before reading:

read_safe() {
  if [ ! -f "$1" ]; then
    echo "Error: File not found: $1" >&2
    return 1
  fi
  cat "$1"
}

read_safe /tmp/sample.txt >/dev/null && echo "File read successfully"
read_safe /nonexistent 2>&1

: # Read from stdin:

echo "Enter your name (or type 'Alice'):"
name="Alice" # Simulated input
echo "Hello, $name"

: # Read with timeout (bash/ksh feature):
: # read -t 5 input  # Wait 5 seconds max

: # Read a single character:
: # read -n 1 char   # Bash-specific

: # Read with prompt:
: # read -p "Enter value: " value  # Bash-specific

: # Count lines, words, characters:

echo "File statistics:"
wc /tmp/sample.txt | while read -r lines words chars filename; do
  echo "  Lines: $lines"
  echo "  Words: $words"
  echo "  Chars: $chars"
done

: # Read binary files (not recommended for text processing):

echo "Binary file info:"
ls -l /bin/sh | cut -d' ' -f5-

: # Read compressed files:

echo "Test" | gzip >/tmp/test.gz
echo "Compressed file content:"
zcat /tmp/test.gz 2>/dev/null || gzip -dc /tmp/test.gz
rm /tmp/test.gz

: # Read from URL (using curl or wget):

# content=$(curl -s https://example.com)
# content=$(wget -qO- https://example.com)

: # [bash]
: # Bash provides mapfile/readarray for reading into arrays:

# mapfile -t lines < /tmp/sample.txt
# echo "Number of lines: ${#lines[@]}"
# echo "First line: ${lines[0]}"

: # Read into array with process substitution:
# mapfile -t users < <(cut -d: -f1 /etc/passwd | head -3)
: # [/bash]

: # Read file descriptor directly:

echo "Using file descriptor:"
exec 3</tmp/sample.txt
read -r first_line <&3
echo "  First line: $first_line"
read -r second_line <&3
echo "  Second line: $second_line"
exec 3<&- # Close file descriptor

: # Read with grep filtering:

echo "Lines containing 'Line':"
grep "Line" /tmp/sample.txt

: # Read random line:

echo "Random line:"
shuf -n 1 /tmp/sample.txt 2>/dev/null \
  || awk 'BEGIN{srand()} {lines[NR]=$0} END{print lines[int(rand()*NR)+1]}' /tmp/sample.txt

: # Cleanup

rm -f /tmp/sample.txt /tmp/data.txt

echo "File reading examples complete"
