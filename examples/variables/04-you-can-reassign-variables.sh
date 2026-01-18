#!/bin/sh
# You can reassign variables at any time, even to different types.
# In this example, we assign a string to a variable, reassign it to a number, and then reassign it to a string again.

variable="world"
echo "Hello, $variable!"
variable=42
echo "Hello, $variable!"
variable="world"
echo "Hello, $variable!"
