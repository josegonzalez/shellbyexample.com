#!/bin/sh
# Create a configuration file:

cat << EOF > /tmp/config.example
# Configuration file
# Generated: $(date)

setting1=value1
setting2=value2
debug=false
EOF

echo "Created config file:"
cat /tmp/config.example
