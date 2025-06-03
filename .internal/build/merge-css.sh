#!/usr/bin/env bash

print_usage() {
  echo "Usage: $0 <input-file>"
  echo "Parses a css file with only import statements, concatenates and outputs the contents of all imports."
  echo ""
  echo "Example:"
  echo "  $0 theme.css"
}

INPUT="$1"

if [[ -z "$INPUT" || ! -f "$INPUT" ]]; then
  print_usage
  exit 1
fi

INPUT_DIR=$(dirname "$INPUT")
DATA=""

while read -r line || [[ -n "$line" ]]; do
  if [[ "$line" =~ \'([^\']+)\' ]]; then
    FILE_NAME="${BASH_REMATCH[1]}"
    FULL_PATH=$(realpath "$INPUT_DIR/$FILE_NAME")

    if [[ -f "$FULL_PATH" ]]; then
      FILE_CONTENT=$(<"$FULL_PATH")
      DATA+="${FILE_CONTENT}\n\n"
    else
      echo "File not found: $FULL_PATH"
      exit 1
    fi

  fi
done <"$INPUT"

DATA="${DATA%\\n}"
printf "%b" "$DATA"
