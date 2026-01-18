#!/bin/sh
# `basename` can strip a suffix:

path="/home/user/documents/report.txt"
echo "Without .txt: $(basename "$path" .txt)"
