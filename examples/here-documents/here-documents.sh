#!/bin/sh

: # Here-documents (heredocs) let you include multi-line
: # text directly in your script. They're great for
: # embedding configuration files, SQL queries, or
: # help text.

: # Basic syntax: <<DELIMITER ... DELIMITER
: # The delimiter can be any word (EOF is common).

cat << EOF
This is a here-document.
It can span multiple lines.
Variables like $HOME are expanded.
EOF

: # Use <<'EOF' (quoted) to prevent variable expansion.

cat << 'EOF'
This text is literal.
$HOME is not expanded here.
Special characters like \n are also literal.
EOF

: # Use <<-EOF to strip leading tabs (not spaces).
: # This helps with indentation in scripts.

	cat <<-EOF
	This line had a leading tab.
	So did this one.
	The tabs are stripped from output.
	EOF

: # Here-documents are commonly used with commands
: # that read from stdin.

: # Send mail (example - won't actually send):

# mail -s "Report" user@example.com << EOF
# Daily report attached.
# Generated on $(date).
# EOF

: # Create a configuration file:

cat << EOF > /tmp/config.example
# Configuration file
# Generated: $(date)

setting1=value1
setting2=value2
debug=false
EOF

echo "Created config file:"
cat /tmp/config.example

: # POSIX uses echo and pipe for single-line input:

echo "search in this string" | grep "string"

: # [bash]
: # Here-strings (<<<) provide a shorthand for passing
: # a string directly to a command's stdin:

# grep "pattern" <<< "search in this string"

: # Here-strings are particularly useful with read:

# read -r first rest <<< "hello world from bash"
# echo "First word: $first"  # hello

: # They can include variable expansion:

# message="Hello, World!"
# tr 'a-z' 'A-Z' <<< "$message"
: # [/bash]

: # Here-documents work great for multi-line variables.

help_text=$(cat << 'EOF'
Usage: myscript [options] <file>

Options:
  -h, --help     Show this help message
  -v, --verbose  Enable verbose output
  -o FILE        Output to FILE

Examples:
  myscript input.txt
  myscript -v -o output.txt input.txt
EOF
)

echo "$help_text"
