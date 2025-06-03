#!/usr/bin/env bash

echo "Copying themes"

mkdir -p ./dist/ros
cp -r src/keycloak/* ./dist/ros
cp ./version.txt ./dist/ros
