#!/bin/bash

THISDIR="$(dirname "$0")"
LANGFILE="$THISDIR/../app_pojavlauncher/src/main/assets/language_list.txt"
rm -f "$LANGFILE"

for dir in "$THISDIR"/../app_pojavlauncher/src/main/res/values-*; do
    [ -d "$dir" ] && basename "$dir"
done > "$LANGFILE"
