#!/bin/sh
# Write without newline using printf:

printf "No newline here" >/tmp/nonewline.txt
printf " - continued\n" >>/tmp/nonewline.txt
cat /tmp/nonewline.txt
