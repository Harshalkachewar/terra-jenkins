#!/bin/bash
set -euo pipefail

DIR="${1:-/tmp/terraform1}"
FILE="${2:-${DIR}/unnati.txt}"

echo "Creating directory: $DIR"
mkdir -p "$DIR"

echo "Creating file: $FILE"
echo "hello world" > "$FILE"
chmod 644 "$FILE"

echo "Directory contents:"
ls -la "$DIR"

echo "File contents:"
cat "$FILE"
