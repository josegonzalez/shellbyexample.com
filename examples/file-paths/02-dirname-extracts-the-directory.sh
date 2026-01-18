#!/bin/sh
# Shell provides several tools for manipulating file
# paths. The key commands are dirname, basename, and
# realpath (or readlink).
#
# `dirname` extracts the directory portion:

path="/home/user/documents/report.txt"
echo "Path: $path"
echo "Directory: $(dirname "$path")"
