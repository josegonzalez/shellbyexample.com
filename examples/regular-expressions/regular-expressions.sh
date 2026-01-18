#!/bin/sh

: # Regular expressions are powerful patterns for
: # matching text. Shell uses regex through commands
: # like grep, sed, and awk.

: # Create sample data for demonstrations:

cat >/tmp/sample.txt <<'EOF'
hello world
Hello World
HELLO WORLD
hello123
hello-world
hello_world
hello.world
test@example.com
user123@domain.org
192.168.1.1
10.0.0.255
2024-03-15
03/15/2024
phone: 555-1234
phone: (555) 123-4567
EOF

: # Basic grep - find lines matching a pattern:

echo "Lines containing 'hello':"
grep "hello" /tmp/sample.txt

: # Case-insensitive search with -i:

echo "Case-insensitive 'hello':"
grep -i "hello" /tmp/sample.txt

: # Basic regex metacharacters:

: # . matches any single character
echo "Pattern 'h.llo':"
grep "h.llo" /tmp/sample.txt

: # * matches zero or more of previous character
echo "Pattern 'hel*o' (zero or more 'l'):"
grep "hel*o" /tmp/sample.txt

: # ^ matches start of line
echo "Lines starting with 'hello':"
grep "^hello" /tmp/sample.txt

: # $ matches end of line
echo "Lines ending with 'world':"
grep "world$" /tmp/sample.txt

: # Character classes with []:

echo "Pattern 'hello[0-9]' (hello + digit):"
grep "hello[0-9]" /tmp/sample.txt

echo "Pattern 'hello[._-]' (hello + separator):"
grep "hello[._-]" /tmp/sample.txt

: # Negated character class with [^]:

echo "Lines with 'hello' NOT followed by digit:"
grep "hello[^0-9]" /tmp/sample.txt

: # Extended regex with -E (or egrep):

echo "Extended regex patterns:"

# + matches one or more
echo "One or more digits:"
grep -E "[0-9]+" /tmp/sample.txt

# ? matches zero or one
echo "Optional 's' (phones?):"
grep -E "phones?" /tmp/sample.txt

# {n,m} matches n to m occurrences
echo "Exactly 3 digits:"
grep -E "[0-9]{3}" /tmp/sample.txt

# | for alternation
echo "Lines with 'hello' or 'test':"
grep -E "hello|test" /tmp/sample.txt

: # Grouping with ():

echo "Grouped pattern ((hello|test)@):"
grep -E "(hello|test)@" /tmp/sample.txt

: # Word boundaries:

echo "Word 'hello' (not part of larger word):"
grep -w "hello" /tmp/sample.txt

: # grep -o shows only matching part:

echo "Extract email addresses:"
grep -oE "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" /tmp/sample.txt

: # grep -v inverts match (show non-matching):

echo "Lines NOT containing 'hello':"
grep -v "hello" /tmp/sample.txt | head -5

: # grep -c counts matches:

echo "Count of lines with 'hello': $(grep -c "hello" /tmp/sample.txt)"

: # grep -n shows line numbers:

echo "With line numbers:"
grep -n "world" /tmp/sample.txt | head -3

: # Using sed for search and replace:

echo "sed substitution examples:"

# Replace first occurrence
echo "hello world world" | sed 's/world/universe/'

# Replace all occurrences (g flag)
echo "hello world world" | sed 's/world/universe/g'

# Case-insensitive (I flag, GNU sed)
echo "Hello HELLO hello" | sed 's/hello/hi/gi'

# Delete lines matching pattern
echo "Delete lines with 'HELLO':"
sed '/HELLO/d' /tmp/sample.txt | head -3

# Print only matching lines (like grep)
echo "sed -n with /p:"
sed -n '/^hello/p' /tmp/sample.txt

: # sed with capture groups:

echo "Capture groups (swap words):"
echo "foo bar" | sed 's/\(foo\) \(bar\)/\2 \1/'

# Extended regex with -E
echo "Extract domain from email:"
echo "user@example.com" | sed -E 's/.*@(.+)/\1/'

: # Using awk for regex:

echo "awk regex examples:"

# Match lines
echo "Lines matching /hello/:"
awk '/hello/' /tmp/sample.txt | head -3

# Negate match
echo "Lines NOT matching /hello/:"
awk '!/hello/' /tmp/sample.txt | head -3

# Match specific field
echo "Field matching:"
echo "alice 30" | awk '$1 ~ /^a/'

: # Common regex patterns:

echo "Common patterns:"

# IP address (simplified)
echo "IP addresses:"
grep -E "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$" /tmp/sample.txt

# Date YYYY-MM-DD
echo "ISO dates:"
grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}$" /tmp/sample.txt

# Phone numbers
echo "Phone numbers:"
grep -E "[0-9]{3}.*[0-9]{4}" /tmp/sample.txt

: # [bash]
: # Bash's =~ operator for regex matching:

# if [[ "hello123" =~ ^hello[0-9]+$ ]]; then
#     echo "Matches!"
#     echo "Full match: ${BASH_REMATCH[0]}"
# fi

: # Capture groups:
# if [[ "user@example.com" =~ ^(.+)@(.+)$ ]]; then
#     echo "User: ${BASH_REMATCH[1]}"
#     echo "Domain: ${BASH_REMATCH[2]}"
# fi
: # [/bash]

: # Validate input with regex:

validate_email() {
  echo "$1" | grep -qE "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
}

if validate_email "test@example.com"; then
  echo "Valid email"
fi

if ! validate_email "invalid-email"; then
  echo "Invalid email"
fi

: # Cleanup

rm /tmp/sample.txt

echo "Regular expressions examples complete"
