#!/bin/bash
# In bash, you can use `coproc` to start a background jobs that avoids named pipes
# and provides an advanced way to perform bidirectional communication between processes.
# It is similar to starting a command with `&` in the background.
#
# The `coproc` function sets a special variable for the process ID
# with the suffix `_PID`. We can use this to wait for the process to finish.

# start a calculator coprocess in the background
coproc calculator {
    bc -l
}

# send a computation to the calculator coprocess
echo "2 + 3" >&"${calculator[1]}"
#
# read the result from the calculator
# shellcheck disable=SC2162
read -u "${calculator[0]}" result

# optionally close stdin ([0]) and stdout ([1])
# to avoid the need to wait for the calculator coproc to finish
# note the special syntax for closing file descriptors
# that requires no spaces between the curly braces and
# the redirection operator
# shellcheck disable=SC2086
# shellcheck disable=SC1083
exec {calculator[0]}<&-
# shellcheck disable=SC2086
# shellcheck disable=SC1083
exec {calculator[1]}>&-

# wait for the calculator to finish
# shellcheck disable=SC2154
wait "$calculator_PID"
echo "Result: $result"
