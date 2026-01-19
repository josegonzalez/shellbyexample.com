#!/bin/sh
# The shell provides special variables for accessing arguments:
#
# - `$0` is the script name (useful for usage messages)
# - `$1`, `$2`, etc. are positional parameters (the arguments)
# - `$#` is the total count of arguments passed
#
# Assigning positional parameters to named variables makes
# your code more readable and self-documenting.

set -- hello world foo bar

echo "Script name (\$0): $0"
echo ""

echo "Positional parameters:"
echo "  First argument (\$1): $1"
echo "  Second argument (\$2): $2"
echo "  Third argument (\$3): $3"
echo ""

echo "Argument count (\$#): $#"
echo ""

# Good practice: assign to named variables for clarity
input_file="$1"
output_file="$2"
echo "Named variables: input=$input_file, output=$output_file"
