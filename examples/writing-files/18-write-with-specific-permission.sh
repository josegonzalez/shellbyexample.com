#!/bin/sh
# Write with specific permissions:

(
  umask 077
  echo "Secret" >/tmp/secret.txt
)
stat -c 'Permissions: %A' /tmp/secret.txt 2>/dev/null || stat -f 'Permissions: %Sp' /tmp/secret.txt
