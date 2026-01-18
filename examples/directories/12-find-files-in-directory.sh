#!/bin/sh
# Find files in directory with find:

mkdir -p /tmp/findtest/sub
touch /tmp/findtest/a.txt /tmp/findtest/b.sh /tmp/findtest/sub/c.txt

echo "Find all files:"
find /tmp/findtest -type f

echo "Find only .txt files:"
find /tmp/findtest -name "*.txt"

echo "Find by type (directories):"
find /tmp/findtest -type d
