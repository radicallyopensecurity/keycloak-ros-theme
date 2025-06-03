#!/usr/bin/env bash

echo "Copying themes"

mkdir -p ./dist/ros
cp -r src/keycloak/* ./dist/ros

mkdir -p dist/ros/account/resources/dist
cp src/shared/images/favicon-32x32.png dist/ros/account/resources/dist/favicon-32x32.png
cp src/shared/images/favicon.png dist/ros/account/resources/dist/favicon.png
