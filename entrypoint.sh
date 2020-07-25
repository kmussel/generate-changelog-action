#!/bin/sh

if [ -n "$GITHUB_WORKSPACE" ]; then
  cd "$GITHUB_WORKSPACE" || exit
fi

if [ -n "$RUN_DIRECTORY" ]; then
  cd "$RUN_DIRECTORY"
fi

if [ -z "$INPUT_REPO" ]; then INPUT_REPO="$GITHUB_REPOSITORY"; fi


# if [ -n "$INPUT_TAG" ]; then ARG_TAG="-t $INPUT_TAG"; fi

# git clone --quiet https://github.com/$REPO &> /dev/null
echo "generate-changelog $* --file -"

changelog=$(generate-changelog $* --file -)

echo $changelog

changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A'}"
changelog="${changelog//$'\r'/'%0D'}"

echo "::set-output name=changelog::$changelog"
