#!/bin/sh
# UUID generation:

echo "UUID generation:"
if command -v uuidgen >/dev/null 2>&1; then
  echo "  UUID: $(uuidgen)"
elif [ -f /proc/sys/kernel/random/uuid ]; then
  echo "  UUID: $(cat /proc/sys/kernel/random/uuid)"
else
  # Generate UUID v4 manually
  uuid=$(od -An -tx1 -N16 /dev/urandom | tr -d ' \n' \
    | sed 's/^\(.\{8\}\)\(.\{4\}\)\(.\{4\}\)\(.\{4\}\)\(.\{12\}\)$/\1-\2-4\3-\4-\5/' \
    | sed 's/^\(.\{19\}\)./\18/')
  echo "  UUID: $uuid"
fi
