#!/bin/sh
# You can also use curly braces for clarity,
# especially when the variable name could be ambiguous.
# Without braces, this would try to create a file with the
# contents "variable" and not "world".

variable="world"
echo "${variable}" >hello.txt
cat hello.txt
