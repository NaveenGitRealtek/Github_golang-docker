#!/bin/bash

# File where the current version is stored
VERSION_FILE="version.txt"

# Read the current version from the file
if [ ! -f $VERSION_FILE ]; then
    echo "0.0.0" > $VERSION_FILE
fi

CURRENT_VERSION=$(cat $VERSION_FILE)

# Increment the patch version
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
VERSION_PARTS[2]=$((VERSION_PARTS[2] + 1))

# New version
NEW_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}"

# Write the new version to the file
echo $NEW_VERSION > $VERSION_FILE

# Output the new version
echo $NEW_VERSION
