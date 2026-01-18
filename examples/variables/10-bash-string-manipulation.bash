#!/bin/bash
# Bash provides powerful string manipulation within
# parameter expansion. These features are not available
# in POSIX sh.
#
# A few examples of string manipulation:
#
# - String length with ${#var}:
# - Substring extraction with ${var:start:length}:
# - Remove prefix with ${var#pattern} (shortest) or
#   ${var##pattern} (longest):
# - Remove suffix with ${var%pattern} (shortest) or
#   ${var%%pattern} (longest):
# - Search and replace with ${var/find/replace} (first)
#   or ${var//find/replace} (all):

message="Hello, World!"
echo "Length: ${#message}"

echo "${message:0:5}"
echo "${message:7}"

path="/home/user/docs/file.txt"
echo "${path##*/}"

echo "${path%/*}"
filename="archive.tar.gz"
echo "${filename%%.*}"

text="hello hello hello"
echo "${text/hello/hi}"
echo "${text//hello/hi}"
