#!/bin/bash
# Read into array with process substitution:

mapfile -t users < <(cut -d: -f1 /etc/passwd | head -3)
