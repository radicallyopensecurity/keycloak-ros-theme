#!/usr/bin/env bash

echo "Creating jar"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

THEME_NAME=keycloak-ros-theme
OUT_JAR="$(pwd)/dist/$THEME_NAME.jar"

mkdir -p "$TMPDIR/META-INF"
mkdir -p "$TMPDIR/theme"
mkdir -p dist

cp ./dist/$THEME_NAME/keycloak-themes.json "$TMPDIR/META-INF/"
cp -r dist/$THEME_NAME "$TMPDIR/theme/"

(
  cd "$TMPDIR" || exit
  zip -r "$OUT_JAR" META-INF theme
)
