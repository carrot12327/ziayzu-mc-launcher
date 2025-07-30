#!/bin/bash

# languagelist_updater.sh
# Script to update language list for PojavLauncher Android app
# Generates language_list.txt from available resource directories

set -e  # Exit on any error

# Get the directory where this script is located
THISDIR="$(dirname "$0")"
LANGFILE="$THISDIR/../app_pojavlauncher/src/main/assets/language_list.txt"

echo "Starting language list update..."
echo "Script directory: $THISDIR"
echo "Target language file: $LANGFILE"

# Remove existing language file if it exists
if [ -f "$LANGFILE" ]; then
    rm -f "$LANGFILE"
    echo "Removed existing language file"
fi

# Create the language list from values-* directories
echo "Scanning for language resource directories..."

# Find all values-* directories and extract language codes
find "$THISDIR/../app_pojavlauncher/src/main/res" -maxdepth 1 -type d -name "values-*" -exec basename {} \; | sort > "$LANGFILE"

# Check if the file was created successfully
if [ -f "$LANGFILE" ]; then
    LANG_COUNT=$(wc -l < "$LANGFILE")
    echo "Language list updated successfully!"
    echo "Found $LANG_COUNT language directories"
    echo "Contents of $LANGFILE:"
    cat "$LANGFILE"
else
    echo "Error: Failed to create language file"
    exit 1
fi

echo "Language list update completed!"
