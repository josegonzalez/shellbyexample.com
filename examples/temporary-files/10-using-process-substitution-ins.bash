#!/bin/bash
# Using process substitution instead of temp files.
# This avoids creating explicit temp files:

echo -e "banana\napple\ncherry" >/tmp/file1.txt
echo -e "apple\nbanana\ndate" >/tmp/file2.txt

diff <(sort /tmp/file1.txt) <(sort /tmp/file2.txt)

rm /tmp/file1.txt /tmp/file2.txt
