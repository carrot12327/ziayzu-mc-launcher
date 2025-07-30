#!/bin/bash

# languagelist_updater.sh
# Script to update language list for PojavLauncher Android app
# Generates language_list.txt from available resource directories

set -e  # Exit on any error

echo "🌍 Starting language list update..."

# Get the directory where this script is located
THISDIR="$(dirname "$0")"
LANGFILE="$THISDIR/../app_pojavlauncher/src/main/assets/language_list.txt"

echo "📁 Script directory: $THISDIR"
echo "📄 Target language file: $LANGFILE"

# Create assets directory if it doesn't exist
ASSETS_DIR="$(dirname "$LANGFILE")"
if [ ! -d "$ASSETS_DIR" ]; then
    echo "📂 Creating assets directory: $ASSETS_DIR"
    mkdir -p "$ASSETS_DIR"
fi

# Remove existing language file if it exists
if [ -f "$LANGFILE" ]; then
    rm -f "$LANGFILE"
    echo "🗑️  Removed existing language file"
fi

# Check if the resources directory exists
RES_DIR="$THISDIR/../app_pojavlauncher/src/main/res"
if [ ! -d "$RES_DIR" ]; then
    echo "❌ Error: Resources directory not found: $RES_DIR"
    exit 1
fi

echo "🔍 Scanning for language resource directories..."

# Create the language list from values-* directories
# Using your original logic with proper error handling
VALUES_DIRS="$RES_DIR/values-*"
if ls $VALUES_DIRS 1> /dev/null 2>&1; then
    # Use your original method: echo and xargs with basename
    echo $VALUES_DIRS | xargs -- basename -a | sort > "$LANGFILE"
    
    # Verify the file was created and has content
    if [ -s "$LANGFILE" ]; then
        LANG_COUNT=$(wc -l < "$LANGFILE")
        echo "✅ Language list updated successfully!"
        echo "📊 Found $LANG_COUNT language directories"
        echo "📋 Contents of language_list.txt:"
        cat "$LANGFILE"
    else
        echo "⚠️  Language file created but is empty"
        touch "$LANGFILE"
    fi
else
    echo "⚠️  No values-* directories found, creating empty language list"
    touch "$LANGFILE"
fi

echo "🎉 Language list update completed successfully!"
