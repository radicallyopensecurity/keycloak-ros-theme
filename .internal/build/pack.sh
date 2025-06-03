#!/usr/bin/env bash

echo "Creating jar"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

OUT_JAR="$(pwd)/dist/ros.jar"

mkdir -p "$TMPDIR/META-INF"
mkdir -p "$TMPDIR/themes"
mkdir -p dist

cp ./theme/keycloak-themes.json "$TMPDIR/META-INF/"
cp -r dist/ros "$TMPDIR/themes/"

(
  cd "$TMPDIR" || exit
  zip -r "$OUT_JAR" META-INF themes
)
