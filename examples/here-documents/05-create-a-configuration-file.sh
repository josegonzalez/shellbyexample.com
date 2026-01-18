#!/bin/sh
# Create a configuration file file with a here-document by
# adding a redirection operator `>/path/to/file` to the beginning
# of the here-document.

cat <<EOF >/tmp/config.example
# Configuration file
# Generated: $(date)

setting1=value1
setting2=value2
debug=false
EOF

echo "Created config file:"
cat /tmp/config.example
