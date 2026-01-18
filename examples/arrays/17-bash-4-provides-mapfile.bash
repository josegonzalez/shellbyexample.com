#!/bin/bash
# Bash 4+ provides `mapfile` (or `readarray`) to read
# lines from a file or command into an array:

mapfile -t lines < /etc/passwd
