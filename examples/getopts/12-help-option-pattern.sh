#!/bin/sh
# Help option pattern:

show_help() {
  cat <<'EOF'
Usage: script [options] [files...]

Options:
  -h        Show this help
  -v        Verbose output
  -o FILE   Output file
  -n NAME   Set name
EOF
}

demo_help() {
  OPTIND=1

  while getopts "hvo:n:" opt; do
    case "$opt" in
      h)
        show_help
        return 0
        ;;
      v) echo "Verbose mode" ;;
      o) echo "Output: $OPTARG" ;;
      n) echo "Name: $OPTARG" ;;
      \?)
        show_help
        return 1
        ;;
    esac
  done
}

echo "Help option:"
set -- -h
demo_help "$@"
