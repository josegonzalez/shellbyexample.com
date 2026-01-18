#!/bin/bash
# Here-strings (<<<) provide a shorthand for passing
# a string directly to a command's stdin:

grep "pattern" <<< "search in this string"
