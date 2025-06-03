#!/usr/bin/env bash

echo "Watching ./src for changes..."

inotifywait -r -m -e modify,create,delete,move ./src |
  while read -r _; do
    echo "Change detected - Building..."
    make copy
    make merge
    echo "Built"
  done
