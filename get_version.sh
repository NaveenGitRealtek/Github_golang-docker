#!/bin/bash
VERSION=""
# get parameters
while getopts v: flag
do
  case "${flag}" in
    v) VERSION=${OPTARG};;
  esac
done
# get highest tag number, and add v0.1.0 if doesn't exist
git fetch --prune --unshallow 2>/dev/null
CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`
if [[ $CURRENT_VERSION == '' ]]
then
  CURRENT_VERSION='v0.1.0'
fi
echo "Current Version: $CURRENT_VERSION"
# replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })
# get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}
if [[ $VERSION == 'major' ]]
then
  VNUM1=v$((VNUM1+1))
elif [[ $VERSION == 'minor' ]]
then
  VNUM2=$((VNUM2+1))
elif [[ $VERSION == 'patch' ]]
then
  VNUM3=$((VNUM3+1))
else
  echo "No version type (https://semver.org/) or incorrect type specified, try: -v [major, minor, patch]"
  exit 1
fi
# create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"
# get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`
# only tag if no tag already
if [ -z "$NEEDS_TAG" ]; then
  echo "Tagged with $NEW_TAG"
  git tag $NEW_TAG
  git push --tags
  git push
else
  echo "Already a tag on this commit"
fi
echo ::set-output name=git-tag::$NEW_TAG
exit 0

# !/bin/bash

# # Docker Hub username
# USERNAME=naveen775
# # Repository name
# REPOSITORY=my-go-app1

# # Fetch the latest version tag from Docker Hub
# latest_version=$(curl -s https://hub.docker.com/v2/repositories/$USERNAME/$REPOSITORY/tags | jq -r '.results[].name' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

# # If there are no tags, start with v1.1.0
# if [ -z "$latest_version" ]; then
#   new_version="v1.1.0"
# else
#   # Increment the minor version number
#   IFS='.' read -r -a version_parts <<< "${latest_version#v}"
#   major=${version_parts[0]}
#   minor=${version_parts[1]}
#   minor=$((minor + 1))
#   new_version="v${major}.${minor}.0"
# fi

# echo "$new_version"



