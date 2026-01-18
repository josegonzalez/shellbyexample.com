#!/bin/sh
# Use single quotes when you want literal text with
# no interpretation of special characters.

# shellcheck disable=SC2016
echo 'The variable is written as $name'
# shellcheck disable=SC2028
echo 'Backslashes are literal: \n \t'
