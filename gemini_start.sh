#!/bin/bash
set -e

VERSION_FILE=~/gemini-cli-version.txt
export PATH="$HOME/global_node/bin:$PATH"

if [ ! -f "$VERSION_FILE" ]; then
  echo "Installing/Updating gemini-cli...\n\n"
  npm i -g @google/gemini-cli
  npm view @google/gemini-cli version > "$VERSION_FILE"
fi

gemini "$@"
echo "Checking for updates..."
echo -e "press ctrl+c to skip...\n\n"
LATEST_VERSION=$(npm view @google/gemini-cli version 2>/dev/null)
CURRENT_VERSION=$(cat "$VERSION_FILE")

if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
  echo -e "Update found, expect slow next start...\n\n"
  rm "$VERSION_FILE"
fi
