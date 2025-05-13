#!/bin/bash
# Test script to verify tables are correct.
# List all tables files in this directory.
# Then, print each table.
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "$(basename "$0") TABLATOR_PY"
    exit 0
fi
set -e      # fail if any command fails
#set -x
readonly PYTHON="$(command -v python3)"
readonly DATA_DIR="$PWD"
readonly TOOL="${1:-$HOME/Source/tablator/src/tablator.py}"
cd "$(dirname "$TOOL")" || exit 1
readonly TABLATOR="$(basename "$TOOL")"

# List tables
"$PYTHON" "$TABLATOR" --data-dir "$DATA_DIR" --list

# Print all tables
readonly TABLES=
for json_file in $(find "$DATA_DIR" -name \*.json); do
    file="$(basename "$json_file" .json)"
    "$PYTHON" "$TABLATOR" --data-dir "$DATA_DIR" --print "$file"
done
for yaml_file in $(find "$DATA_DIR" -name \*.yaml); do
    file="$(basename "$yaml_file" .yaml)"
    "$PYTHON" "$TABLATOR" --data-dir "$DATA_DIR" --print "$file"
done
