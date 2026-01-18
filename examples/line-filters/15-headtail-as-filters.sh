#!/bin/sh
# `head` and `tail` can be used as filters:

echo "Head and tail:"
seq 1 10 | head -3
seq 1 10 | tail -3
