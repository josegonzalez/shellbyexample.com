#!/bin/bash
# Case conversion (bash 4+):

word="Hello World"
echo "Uppercase: ${word^^}"
echo "Lowercase: ${word,,}"
echo "First char upper: ${word^}"
echo "First char lower: ${word,}"
