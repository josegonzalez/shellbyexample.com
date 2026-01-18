#!/bin/bash
# Iterate over associative array keys:

declare -A user
user[name]="Alice"
user[email]="alice@example.com"
user[age]="30"

for key in "${!user[@]}"; do
    echo "$key: ${user[$key]}"
done
