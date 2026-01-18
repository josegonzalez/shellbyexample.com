#!/bin/sh
# Group and count:

data='[{"type":"a"},{"type":"b"},{"type":"a"},{"type":"c"},{"type":"a"}]'
echo "Group by type:"
echo "$data" | jq 'group_by(.type) | map({type: .[0].type, count: length})'
