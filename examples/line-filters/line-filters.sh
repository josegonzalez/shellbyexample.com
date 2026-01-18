#!/bin/sh

: # Line filters read from stdin, transform data, and
: # write to stdout. The `while read` pattern is the
: # foundation of shell line processing.

: # Basic while read loop:

echo "Basic line reading:"
printf "line1\nline2\nline3\n" | while read -r line; do
  echo "  Got: $line"
done

: # The -r flag prevents backslash interpretation.
: # Always use quotes around $line to preserve whitespace.

: # Process a file line by line:

cat >/tmp/data.txt <<'EOF'
apple 10 red
banana 20 yellow
cherry 15 red
date 25 brown
EOF

echo "Processing file:"
while read -r fruit count color; do
  echo "  $fruit ($color): $count items"
done </tmp/data.txt

: # IFS controls field splitting:

echo "Custom delimiter (CSV):"
printf "alice,30,engineer\nbob,25,designer\n" | while IFS=, read -r name age job; do
  echo "  $name is $age, works as $job"
done

: # Read from command output:

echo "Reading from command:"
ls -la /tmp 2>/dev/null | head -5 | while read -r line; do
  echo "  $line"
done

: # Filter pattern: transform each line

echo "Transform each line (uppercase):"
printf "hello\nworld\n" | while read -r line; do
  echo "$line" | tr '[:lower:]' '[:upper:]'
done

: # Filter with awk (more efficient for simple transforms):

echo "Using awk as filter:"
printf "10\n20\n30\n" | awk '{print $1 * 2}'

: # Numbering lines:

echo "Number lines:"
n=1
printf "first\nsecond\nthird\n" | while read -r line; do
  printf "%3d: %s\n" "$n" "$line"
  n=$((n + 1))
done

: # Skip header line:

echo "Skip header:"
cat >/tmp/csv.txt <<'EOF'
name,age,city
Alice,30,NYC
Bob,25,LA
Carol,35,Chicago
EOF

head -1 /tmp/csv.txt
tail -n +2 /tmp/csv.txt | while IFS=, read -r name age city; do
  echo "  $name from $city"
done

: # Filter out empty lines:

echo "Skip empty lines:"
printf "line1\n\nline2\n\nline3\n" | while read -r line; do
  [ -z "$line" ] && continue
  echo "  $line"
done

: # Filter with grep before processing:

echo "Pre-filter with grep:"
grep "red" /tmp/data.txt | while read -r fruit count color; do
  echo "  Red fruit: $fruit"
done

: # Accumulate values:

echo "Sum numbers:"
total=0
printf "10\n20\n30\n" | (
  while read -r n; do
    total=$((total + n))
  done
  echo "Total: $total"
)

: # Note: Variables set in piped while loops don't persist
: # outside due to subshell. Use a different approach:

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

: # Process with multiple passes:

echo "Multi-pass processing:"
# Pass 1: Filter
# Pass 2: Transform
cat /tmp/data.txt | grep -v "date" | awk '{print $1, $2 * 2}'

: # Tee for debugging pipelines:

echo "Debug with tee:"
printf "a\nb\nc\n" | tee /dev/stderr | tr '[:lower:]' '[:upper:]'

: # xargs as line processor:

echo "Using xargs:"
printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing: {}"

: # Parallel processing with xargs:

# echo "file1 file2 file3" | xargs -n1 -P3 process_file

: # head/tail as filters:

echo "Head and tail:"
seq 1 10 | head -3
seq 1 10 | tail -3

: # uniq for deduplication (requires sorted input):

echo "Unique lines:"
printf "a\na\nb\nc\nc\nc\n" | uniq

echo "Count occurrences:"
printf "a\na\nb\nc\nc\nc\n" | uniq -c

: # sort as filter:

echo "Sorted output:"
printf "cherry\napple\nbanana\n" | sort

: # cut for field extraction:

echo "Extract fields with cut:"
echo "name:age:city" | cut -d: -f2

: # Handle last line without newline:

echo "Handle missing final newline:"
printf "line1\nline2" | while IFS= read -r line || [ -n "$line" ]; do
  echo "  [$line]"
done

: # Practical example: Log analyzer

cat >/tmp/access.log <<'EOF'
192.168.1.1 GET /index.html 200
192.168.1.2 GET /about.html 200
192.168.1.1 POST /api/data 201
192.168.1.3 GET /index.html 404
192.168.1.2 GET /contact.html 200
EOF

echo "Log analysis:"
echo "  Unique IPs:"
cut -d' ' -f1 /tmp/access.log | sort -u | while read -r ip; do
  echo "    $ip"
done

echo "  Status code counts:"
cut -d' ' -f4 /tmp/access.log | sort | uniq -c

: # Cleanup

rm -f /tmp/data.txt /tmp/csv.txt /tmp/access.log

echo "Line filter examples complete"
