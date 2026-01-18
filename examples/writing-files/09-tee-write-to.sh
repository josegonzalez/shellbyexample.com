#!/bin/sh
# Tee - write to file and stdout simultaneously:

echo "Using tee:"
echo "This goes to both" | tee /tmp/tee.txt
echo "File contains: $(cat /tmp/tee.txt)"

echo "Append with tee -a:"
echo "Appended line" | tee -a /tmp/tee.txt >/dev/null
cat /tmp/tee.txt
