#!/usr/bin/env bash

SHARED_DIR="./src/shared"
THEME="$SHARED_DIR/styles/theme.css"
MERGE_SCRIPT="./.internal/build/merge-css.sh"
DIST_DIR="./dist/ros"
FILE_NAME="ros.css"

MERGED_CSS="$("$MERGE_SCRIPT" "$THEME")"

find "$DIST_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r THEME_DIR; do
  RESOURCE_DIR="$THEME_DIR/resources"
  CSS_DIR="$RESOURCE_DIR/css"

  mkdir -p "$CSS_DIR"
  echo "Writing to $CSS_DIR/$FILE_NAME"
  printf "%s" "$MERGED_CSS" >"$CSS_DIR/$FILE_NAME"

  cp "$SHARED_DIR/images/"* "$RESOURCE_DIR"
done
