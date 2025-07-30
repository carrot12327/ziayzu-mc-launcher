#!/bin/bash

# Get the directory where this script is located
THISDIR=$(dirname "$0")

# Target language list file relative to the script directory
LANGFILE="$THISDIR/../app_pojavlauncher/src/main/assets/language_list.txt"

# Directory containing the language resource folders
VALUES_DIR="$THISDIR/../app_pojavlauncher/src/main/res"

# Check if the res directory exists
if [[ ! -d "$VALUES_DIR" ]]; then
  echo "ERROR: Resource directory not found: $VALUES_DIR"
  exit 1
fi

# Find all 'values-*' directories inside the res folder
LANG_FOLDERS=()
while IFS= read -r -d $'\0' dir; do
  LANG_FOLDERS+=("$(basename "$dir")")
done < <(find "$VALUES_DIR" -maxdepth 1 -type d -name 'values-*' -print0 | sort -z)

if [[ ${#LANG_FOLDERS[@]} -eq 0 ]]; then
  echo "No language folders found matching 'values-*' in $VALUES_DIR"
  # Clear or create an empty language list file
  > "$LANGFILE"
  exit 0
fi

# Write the language folder names to LANGFILE, one per line
printf "%s\n" "${LANG_FOLDERS[@]}" > "$LANGFILE"

echo "Language list updated successfully at $LANGFILE"
exit 0
