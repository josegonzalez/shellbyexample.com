#!/bin/sh
# Extended regex with -E (or egrep):

echo "Extended regex patterns:"

# + matches one or more
echo "One or more digits:"
grep -E "[0-9]+" /tmp/sample.txt

# ? matches zero or one
echo "Optional 's' (phones?):"
grep -E "phones?" /tmp/sample.txt

# {n,m} matches n to m occurrences
echo "Exactly 3 digits:"
grep -E "[0-9]{3}" /tmp/sample.txt

# | for alternation
echo "Lines with 'hello' or 'test':"
grep -E "hello|test" /tmp/sample.txt
