#!/bin/sh
# The backslash escapes single characters. In this example, we escape the double quote,
# the backslash, and the dollar sign.

echo "She said \"Hello\""
# shellcheck disable=SC2028
echo "Path: C:\\Users\\name"
echo "Dollar sign: \$100"
