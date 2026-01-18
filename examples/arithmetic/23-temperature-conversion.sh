#!/bin/sh
# Temperature conversion:

celsius=25
fahrenheit=$(echo "scale=1; $celsius * 9/5 + 32" | bc)
echo "Temperature: ${celsius}C = ${fahrenheit}F"
