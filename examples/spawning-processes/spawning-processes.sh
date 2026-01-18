#!/bin/sh

: # Shell provides several ways to spawn and control
: # processes. This covers subshells, command execution,
: # and process management.

: # Basic command execution:

echo "Running a command:"
ls -la /tmp | head -3

: # Commands in a subshell with ():

echo "Subshell demo:"
(
  cd /tmp
  echo "  In subshell: $(pwd)"
  x="subshell_value"
)
echo "  After subshell: $(pwd)"
echo "  x is: ${x:-unset}"

: # Subshells don't affect parent environment.

: # Command groups with {} run in current shell:

echo "Command group demo:"
{
  y="group_value"
  echo "  In group"
}
echo "  y is: $y"

: # Capture command output with $():

files=$(ls -1 /tmp | head -3)
echo "Captured output:"
echo "$files"

: # Capture with backticks (older style, avoid):

date_old=$(date +%Y-%m-%d)
echo "Date: $date_old"

: # $() can be nested easily:

echo "Nested: $(basename $(dirname /usr/local/bin))"

: # Pipes connect stdout to stdin:

echo "Pipeline:"
echo -e "cherry\napple\nbanana" | sort | head -2

: # Pipeline exit status is the last command's status:

echo "apple" | grep -q "banana"
echo "Pipeline exit: $?"

: # [bash]
: # Bash's PIPESTATUS gives all exit codes:
# echo "test" | false | true
# echo "PIPESTATUS: ${PIPESTATUS[@]}"
: # [/bash]

: # [bash]
: # Process substitution (bash):
# diff <(ls /bin) <(ls /usr/bin)
# while read -r line; do
#     echo "Line: $line"
# done < <(ls -la)
: # [/bash]

: # POSIX alternative uses temp files or named pipes:

echo "POSIX diff comparison:"
tmpf1=$(mktemp)
tmpf2=$(mktemp)
ls /bin >"$tmpf1"
ls /usr/bin >"$tmpf2"
diff "$tmpf1" "$tmpf2" | head -5
rm "$tmpf1" "$tmpf2"

: # Named pipe for process communication:

echo "Named pipe communication:"
fifo=$(mktemp -u)
mkfifo "$fifo"

# Producer
(echo "Hello from producer" >"$fifo") &
producer_pid=$!

# Consumer
message=$(cat "$fifo")
echo "Received: $message"

wait $producer_pid
rm "$fifo"

: # Run command with timeout:

if command -v timeout >/dev/null 2>&1; then
  echo "Timeout demo:"
  timeout 1 sleep 5 || echo "  Command timed out"
fi

: # Check if command exists before running:

if command -v git >/dev/null 2>&1; then
  echo "git is installed"
else
  echo "git is not installed"
fi

: # Run command conditionally:

echo "Conditional execution:"
true && echo "  After success"
false || echo "  After failure"
false && echo "  Won't run"
true || echo "  Won't run"

: # Compound conditionals:

echo "Compound:"
(true && true) && echo "  Both true"
(true || false) && echo "  At least one true"

: # Command substitution in conditionals:

if [ "$(echo hello)" = "hello" ]; then
  echo "Command output matches"
fi

: # Spawn and forget (nohup):

# nohup long_running_command > /dev/null 2>&1 &
echo "nohup keeps command running after logout"

: # Get PID of current script:

echo "Script PID: $$"
echo "Parent PID: $PPID"

: # Fork bomb protection - NEVER run this:
: # :(){ :|:& };:  # This is a fork bomb, DO NOT RUN

: # Execute command from string:

cmd="echo 'Hello from eval'"
eval "$cmd"

: # Be careful with eval - avoid if possible.

: # exec replaces current process:

demo_exec() {
  (
    echo "Before exec"
    exec echo "This replaces the subshell"
    echo "This never runs"
  )
  echo "After subshell"
}
demo_exec

: # xargs for batch processing:

echo "xargs demo:"
printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing {}"

: # Parallel execution with xargs:

# echo "a b c" | xargs -n1 -P3 process_item

: # Wait for specific process:

(
  sleep 1
  echo "  Process 1 done"
) &
pid1=$!
(
  sleep 2
  echo "  Process 2 done"
) &
pid2=$!

echo "Waiting for process $pid1..."
wait $pid1
echo "Process $pid1 finished"

echo "Waiting for all..."
wait

: # Check if process is running:

sleep 10 &
pid=$!
if kill -0 $pid 2>/dev/null; then
  echo "Process $pid is running"
  kill $pid # Clean up
fi

: # Source a script (run in current shell):

echo "source demo:"
tmpscript=$(mktemp)
echo 'SOURCED_VAR="from sourced script"' >"$tmpscript"
. "$tmpscript" # POSIX way to source
echo "SOURCED_VAR: $SOURCED_VAR"
rm "$tmpscript"

echo "Spawning processes examples complete"
