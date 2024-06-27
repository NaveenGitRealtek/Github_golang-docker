#!/bin/bash

# Check if VERSION file exists
if [ -f VERSION ]; then
    # Read the current version from the file
    CURRENT_VERSION=$(cat VERSION)
    # Split the version into its components (assuming vMAJOR.MINOR.PATCH format)
    MAJOR=$(echo $CURRENT_VERSION | cut -d '.' -f 1 | cut -d 'v' -f 2)
    MINOR=$(echo $CURRENT_VERSION | cut -d '.' -f 2)
    PATCH=$(echo $CURRENT_VERSION | cut -d '.' -f 3)
    
    # Increment the patch version
    PATCH=$((PATCH + 1))
    
    # Form the new version string
    NEW_VERSION="v$MAJOR.$MINOR.$PATCH"
else
    # If VERSION file does not exist, start with v0.0.1
    NEW_VERSION="v0.0.1"
fi

# Output the new version
echo $NEW_VERSION

# Update the VERSION file
echo $NEW_VERSION > VERSION

# Build and push the Docker image with the new version
docker build -t naveen775/my-go-app1:$NEW_VERSION .
docker push naveen775/my-go-app1:$NEW_VERSION

