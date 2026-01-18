#!/bin/sh
# grep -c counts matches:

echo "Count of lines with 'hello': $(grep -c "hello" /tmp/sample.txt)"
