#!/bin/sh

: # The `sort` command is essential for ordering data.
: # It handles text, numbers, and complex sorting rules.

: # Basic alphabetical sort:

echo "Basic sort:"
printf "cherry\napple\nbanana\ndate\n" | sort

: # Reverse order with -r:

echo "Reverse sort:"
printf "cherry\napple\nbanana\n" | sort -r

: # Numeric sort with -n:

echo "Numeric sort:"
printf "10\n2\n100\n25\n1\n" | sort -n

: # Without -n, numbers sort lexicographically:

echo "Lexicographic (wrong for numbers):"
printf "10\n2\n100\n25\n1\n" | sort

: # Human-readable sizes with -h:

echo "Human-readable sizes:"
printf "1K\n10M\n500K\n1G\n100\n" | sort -h

: # Sort by specific field with -k:

cat >/tmp/data.txt <<'EOF'
Alice 30 NYC
Bob 25 LA
Carol 35 Chicago
Dave 25 Boston
EOF

echo "Sort by second field (age):"
sort -k2 -n /tmp/data.txt

echo "Sort by third field (city):"
sort -k3 /tmp/data.txt

: # Multiple sort keys:

echo "Sort by age, then name:"
sort -k2,2n -k1,1 /tmp/data.txt

: # Custom field delimiter with -t:

cat >/tmp/passwd.txt <<'EOF'
root:0:root
alice:1000:Alice User
bob:1001:Bob Smith
daemon:1:daemon
EOF

echo "Sort /etc/passwd-like by UID (field 2):"
sort -t: -k2 -n /tmp/passwd.txt

: # Unique sort with -u:

echo "Unique values only:"
printf "apple\nbanana\napple\ncherry\nbanana\n" | sort -u

: # Case-insensitive sort with -f:

echo "Case-insensitive:"
printf "Apple\nbanana\nAPRICOT\ncherry\n" | sort -f

: # Check if already sorted with -c:

echo "Check if sorted:"
printf "a\nb\nc\n" | sort -c && echo "  Already sorted"
printf "b\na\nc\n" | sort -c 2>&1 | head -1

: # Sort in place with -o (output to same file):

echo "apple" >/tmp/fruits.txt
echo "cherry" >>/tmp/fruits.txt
echo "banana" >>/tmp/fruits.txt
sort -o /tmp/fruits.txt /tmp/fruits.txt
echo "Sorted in place:"
cat /tmp/fruits.txt

: # Random shuffle with -R (or shuf command):

echo "Random order:"
printf "1\n2\n3\n4\n5\n" | sort -R 2>/dev/null || shuf

: # Sort by month names with -M:

echo "Month sort:"
printf "March\nJanuary\nDecember\nJune\n" | sort -M

: # Version number sort with -V:

echo "Version sort:"
printf "v1.10\nv1.2\nv1.9\nv2.0\n" | sort -V 2>/dev/null || echo "  (requires GNU sort)"

: # Stable sort with -s (preserve original order for equal elements):

echo "Stable sort:"
cat >/tmp/scores.txt <<'EOF'
Alice 90
Bob 85
Carol 90
Dave 85
EOF

sort -s -k2 -n -r /tmp/scores.txt

: # Sort with uniq for frequency counting:

echo "Word frequency:"
printf "apple\nbanana\napple\napple\ncherry\nbanana\n" | sort | uniq -c | sort -rn

: # Top N results:

echo "Top 2 most frequent:"
printf "a\nb\na\nc\na\nb\nd\n" | sort | uniq -c | sort -rn | head -2

: # Parallel sort for large files (GNU sort):
: # sort --parallel=4 largefile.txt

: # External sort (handles files larger than memory):
: # sort automatically uses temp files for large inputs

: # Locale affects sort order:

echo "Locale-independent sort (C locale):"
printf "Étoile\nApple\néclair\nBanana\n" | LC_ALL=C sort

: # Sort and merge multiple files:

echo "one" >/tmp/f1.txt
echo "three" >>/tmp/f1.txt
echo "two" >/tmp/f2.txt
echo "four" >>/tmp/f2.txt

echo "Merge sorted files:"
sort /tmp/f1.txt /tmp/f2.txt

: # Practical examples:

: # Sort IP addresses:

echo "Sort IP addresses:"
printf "192.168.1.10\n192.168.1.2\n10.0.0.1\n" | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n

: # Sort by file size:

echo "Files by size:"
ls -l /tmp/*.txt 2>/dev/null | sort -k5 -n | tail -3

: # Sort CSV by column:

cat >/tmp/sales.csv <<'EOF'
product,quantity,price
Apple,100,1.50
Banana,50,0.75
Cherry,75,2.00
EOF

echo "Sort CSV by quantity (column 2):"
tail -n +2 /tmp/sales.csv | sort -t, -k2 -n

: # Cleanup

rm -f /tmp/data.txt /tmp/passwd.txt /tmp/fruits.txt /tmp/scores.txt
rm -f /tmp/f1.txt /tmp/f2.txt /tmp/sales.csv

echo "Sorting examples complete"
