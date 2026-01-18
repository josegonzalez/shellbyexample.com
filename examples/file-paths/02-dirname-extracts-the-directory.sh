#!/bin/sh
# dirname extracts the directory portion:

path="/home/user/documents/report.txt"
echo "Path: $path"
echo "Directory: $(dirname "$path")"
