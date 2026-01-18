#!/bin/sh
# Pipeline exit status is the last command's status:

echo "apple" | grep -q "banana"
echo "Pipeline exit: $?"
