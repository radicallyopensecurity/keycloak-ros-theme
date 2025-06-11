#!/usr/bin/env bash

echo "Copying themes"

THEME_NAME=keycloak-ros-theme

mkdir -p "./dist/keycloak-ros-theme"
cp -r src/keycloak/* "./dist/keycloak-ros-theme"

mkdir -p "dist/keycloak-ros-theme/account/resources/dist"
cp src/shared/images/favicon-32x32.png "dist/keycloak-ros-theme/account/resources/dist/favicon-32x32.png"
cp src/shared/images/favicon.png "dist/keycloak-ros-theme/account/resources/dist/favicon.png"
