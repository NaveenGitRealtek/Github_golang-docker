# #!/bin/bash

# # Check if VERSION file exists
# if [ -f VERSION ]; then
#     # Read the current version from the file
#     CURRENT_VERSION=$(cat VERSION)
#     # Split the version into its components (assuming vMAJOR.MINOR.PATCH format)
#     MAJOR=$(echo $CURRENT_VERSION | cut -d '.' -f 1)
#     MINOR=$(echo $CURRENT_VERSION | cut -d '.' -f 2)
#     PATCH=$(echo $CURRENT_VERSION | cut -d '.' -f 3)
    
#     # Increment the patch version
#     PATCH=$((PATCH + 1))
    
#     # Form the new version string
#     NEW_VERSION="v$MAJOR.$MINOR.$PATCH"
# else
#     # If VERSION file does not exist, start with v0.0.1
#     NEW_VERSION="v0.0.1"
# fi

# # Output the new version
# echo $NEW_VERSION

# #!/bin/bash

# # Docker Hub username
# USERNAME=naveen775
# # Repository name
# REPOSITORY=my-go-app1

# # Fetch the latest version tag from Docker Hub
# latest_version=$(curl -s https://hub.docker.com/v2/repositories/$USERNAME/$REPOSITORY/tags | jq -r '.results[].name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

# # If there are no tags, start with v0.0.1
# if [ -z "$latest_version" ]; then
#   new_version="v0.0.1"
# else
#   # Increment the version number
#   IFS='.' read -r -a version_parts <<< "${latest_version#v}"
#   major=${version_parts[0]}
#   minor=${version_parts[1]}
#   patch=${version_parts[2]}
#   patch=$((patch + 1))
#   new_version="v${major}.${minor}.${patch}"
# fi

# echo "$new_version"

#!/bin/bash

# Docker Hub username
USERNAME=naveen775
# Repository name
REPOSITORY=my-go-app1

# Fetch the latest version tag from Docker Hub
latest_version=$(curl -s https://hub.docker.com/v2/repositories/$USERNAME/$REPOSITORY/tags | jq -r '.results[].name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

# If there are no tags, start with v1.0.0
if [ -z "$latest_version" ]; then
  new_version="v1.0.0"
else
  # Increment the major version number
  IFS='.' read -r -a version_parts <<< "${latest_version#v}"
  major=${version_parts[0]}
  major=$((major + 1))
  new_version="v${major}.0.0"
fi

echo "$new_version"


