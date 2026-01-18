#!/bin/sh
# `IFS` controls field splitting:

echo "Custom delimiter (CSV):"
printf "alice,30,engineer\nbob,25,designer\n" | while IFS=, read -r name age job; do
  echo "  $name is $age, works as $job"
done
