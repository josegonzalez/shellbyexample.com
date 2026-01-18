#!/bin/sh
# `shift` removes the first argument and shifts others down:

set -- first second third fourth
echo "Before shift: $1 $2 $3 $4"
shift
echo "After shift: $1 $2 $3"
shift 2
echo "After shift 2: $1"
