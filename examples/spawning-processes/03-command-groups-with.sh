#!/bin/sh
# Command groups with {} run in current shell:

echo "Command group demo:"
{
  y="group_value"
  echo "  In group"
}
echo "  y is: $y"
