#!/bin/sh
# Date arithmetic (GNU date):

echo "Date arithmetic:"
if date -d "tomorrow" >/dev/null 2>&1; then
  # GNU date
  echo "  Tomorrow: $(date -d 'tomorrow' '+%Y-%m-%d')"
  echo "  Yesterday: $(date -d 'yesterday' '+%Y-%m-%d')"
  echo "  Next week: $(date -d '+7 days' '+%Y-%m-%d')"
  echo "  Last month: $(date -d '-1 month' '+%Y-%m-%d')"
elif date -v+1d >/dev/null 2>&1; then
  # BSD/macOS date
  echo "  Tomorrow: $(date -v+1d '+%Y-%m-%d')"
  echo "  Yesterday: $(date -v-1d '+%Y-%m-%d')"
  echo "  Next week: $(date -v+7d '+%Y-%m-%d')"
  echo "  Last month: $(date -v-1m '+%Y-%m-%d')"
else
  echo "  Date arithmetic not available"
fi
