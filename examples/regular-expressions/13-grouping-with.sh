#!/bin/sh
# Grouping with ():

echo "Grouped pattern ((hello|test)@):"
grep -E "(hello|test)@" /tmp/sample.txt
