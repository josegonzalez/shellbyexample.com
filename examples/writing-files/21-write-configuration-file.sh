#!/bin/sh
# Write configuration file:

write_config() {
  cat >"$1" <<EOF
# Configuration file
# Generated on $(date)

host=localhost
port=8080
debug=false
EOF
}

write_config /tmp/app.conf
echo "Config file:"
cat /tmp/app.conf
