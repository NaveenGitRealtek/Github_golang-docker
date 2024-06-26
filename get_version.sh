#!/bin/bash
# Function to get the type of version bump
get_version_bump_type() {
    # Check for "BREAKING CHANGE" in commit messages
    if git log -1 --pretty=%B | grep -q "major changes"; then
        echo "major"
    # Check for "feat" in commit messages
    elif git log -1 --pretty=%B | grep -q "minor changes"; then
        echo "minor"
    # Default to "fix" or any other change
    else
        echo "patch"
    fi
}
# Determine the version bump type
VERSION_BUMP_TYPE=$(get_version_bump_type)
# Check if VERSION file exists
if [ -f VERSION ]; then
    # Read the current version from the file
    CURRENT_VERSION=$(cat VERSION)
    # Split the version into its components (assuming vMAJOR.MINOR.PATCH format)
    MAJOR=$(echo $CURRENT_VERSION | cut -d '.' -f 1 | tr -d 'v')
    MINOR=$(echo $CURRENT_VERSION | cut -d '.' -f 2)
    PATCH=$(echo $CURRENT_VERSION | cut -d '.' -f 3)
    # Increment the appropriate version component
    if [ "$VERSION_BUMP_TYPE" = "major" ]; then
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
    elif [ "$VERSION_BUMP_TYPE" = "minor" ]; then
        MINOR=$((MINOR + 1))
        PATCH=0
    else
        PATCH=$((PATCH + 1))
    fi
    # Form the new version string
    NEW_VERSION="v$MAJOR.$MINOR.$PATCH"
else
    # If VERSION file does not exist, start with v0.0.1
    NEW_VERSION="v0.0.1"
fi
# Output the new version
echo $NEW_VERSION
# Write the new version back to VERSION file for next build
echo $NEW_VERSION > VERSION
