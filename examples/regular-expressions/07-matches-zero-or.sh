#!/bin/sh
# * matches zero or more of previous character

echo "Pattern 'hel*o' (zero or more 'l'):"
grep "hel*o" /tmp/sample.txt
