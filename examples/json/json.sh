#!/bin/sh

: # Working with JSON in shell typically requires `jq`,
: # a powerful command-line JSON processor. This example
: # covers common jq patterns.

: # Check if jq is available:

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is not installed. Install it with:"
  echo "  brew install jq      # macOS"
  echo "  apt install jq       # Debian/Ubuntu"
  echo "  yum install jq       # RHEL/CentOS"
  exit 0
fi

: # Sample JSON for demonstrations:

json='{"name":"Alice","age":30,"city":"NYC","active":true}'

: # Pretty print JSON:

echo "Pretty print:"
echo "$json" | jq '.'

: # Extract a field:

echo "Extract field:"
echo "$json" | jq '.name'

: # Extract raw value (no quotes):

echo "Raw value:"
echo "$json" | jq -r '.name'

: # Multiple fields:

echo "Multiple fields:"
echo "$json" | jq -r '.name, .city'

: # Nested objects:

nested='{"user":{"name":"Bob","address":{"city":"LA","zip":"90001"}}}'
echo "Nested access:"
echo "$nested" | jq '.user.address.city'

: # Arrays:

array='[{"id":1,"name":"Alice"},{"id":2,"name":"Bob"},{"id":3,"name":"Carol"}]'

echo "Array access:"
echo "$array" | jq '.[0]'   # First element
echo "$array" | jq '.[-1]'  # Last element
echo "$array" | jq '.[1:3]' # Slice

: # Iterate over array:

echo "Array iteration:"
echo "$array" | jq -r '.[].name'

: # Array length:

echo "Array length: $(echo "$array" | jq 'length')"

: # Filter array:

echo "Filter (id > 1):"
echo "$array" | jq '.[] | select(.id > 1)'

: # Map over array:

echo "Map (extract names):"
echo "$array" | jq '[.[].name]'

: # Transform array:

echo "Transform (add field):"
echo "$array" | jq 'map(. + {status: "active"})'

: # Create JSON:

echo "Create JSON:"
jq -n --arg name "Dave" --arg age "25" \
  '{"name": $name, "age": ($age | tonumber)}'

: # Create from variables:

name="Eve"
age="28"
echo "From variables:"
jq -n --arg n "$name" --argjson a "$age" '{"name": $n, "age": $a}'

: # Modify JSON:

echo "Add field:"
echo "$json" | jq '. + {"country": "USA"}'

echo "Update field:"
echo "$json" | jq '.age = 31'

echo "Delete field:"
echo "$json" | jq 'del(.city)'

: # Conditional updates:

echo "Conditional update:"
echo "$array" | jq 'map(if .id == 2 then .name = "Robert" else . end)'

: # Sort array:

echo "Sort by name:"
echo "$array" | jq 'sort_by(.name)'

echo "Sort by id (reverse):"
echo "$array" | jq 'sort_by(.id) | reverse'

: # Group and count:

data='[{"type":"a"},{"type":"b"},{"type":"a"},{"type":"c"},{"type":"a"}]'
echo "Group by type:"
echo "$data" | jq 'group_by(.type) | map({type: .[0].type, count: length})'

: # Check if key exists:

echo "Key exists:"
echo "$json" | jq 'has("name")'
echo "$json" | jq 'has("email")'

: # Default values:

echo "Default for missing:"
echo "$json" | jq '.email // "no email"'

: # Type checking:

echo "Type of value:"
echo "$json" | jq '.name | type'
echo "$json" | jq '.age | type'
echo "$json" | jq '.active | type'

: # String operations:

echo "String operations:"
echo '{"msg":"hello world"}' | jq '.msg | ascii_upcase'
echo '{"msg":"hello world"}' | jq '.msg | split(" ")'
echo '{"msg":"hello world"}' | jq '.msg | length'

: # Arithmetic:

echo "Arithmetic:"
echo '{"a":10,"b":3}' | jq '.a + .b'
echo '{"a":10,"b":3}' | jq '.a * .b'
echo '{"a":10,"b":3}' | jq '.a / .b'

: # Compact output (no pretty print):

echo "Compact:"
echo "$array" | jq -c '.'

: # Read JSON from file:

tmpfile=$(mktemp)
echo "$array" >"$tmpfile"
echo "From file:"
jq '.[0].name' "$tmpfile"
rm "$tmpfile"

: # Process multiple JSON objects (jsonl):

echo "JSONL processing:"
printf '{"id":1}\n{"id":2}\n{"id":3}\n' | jq -c '.id *= 10'

: # Error handling:

echo "Safe access (null for missing):"
echo "$json" | jq '.missing?'

echo "Try-catch:"
echo '{"x": "not a number"}' | jq 'try (.x | tonumber) catch "invalid"'

: # Combine with shell:

echo "Shell integration:"
result=$(echo "$json" | jq -r '.name')
echo "Name is: $result"

: # Loop over JSON array in shell:

echo "Loop in shell:"
echo "$array" | jq -c '.[]' | while read -r item; do
  name=$(echo "$item" | jq -r '.name')
  echo "  Processing: $name"
done

: # Build JSON from loop:

echo "Build from loop:"
{
  echo '['
  first=true
  for i in 1 2 3; do
    $first || echo ','
    first=false
    printf '{"num":%d}' "$i"
  done
  echo ']'
} | jq '.'

: # Convert to/from other formats:

echo "To CSV-like:"
echo "$array" | jq -r '.[] | [.id, .name] | @csv'

echo "To shell variables:"
eval "$(echo "$json" | jq -r '@sh "name=\(.name) age=\(.age)"')"
echo "  name=$name, age=$age"

echo "JSON examples complete"
