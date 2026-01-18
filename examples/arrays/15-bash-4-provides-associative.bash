#!/bin/bash
# Bash 4+ provides associative arrays (hash maps)
# using `declare -A`:

declare -A user
user[name]="Alice"
user[email]="alice@example.com"
user[age]="30"

echo "Name: ${user[name]}"
echo "Email: ${user[email]}"
