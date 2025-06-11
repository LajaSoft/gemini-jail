#!/bin/bash

# Build script that detects current user parameters and exports them for docker-compose

script_dir=$(dirname $(realpath $0))
pushd .
cd $script_dir

mkdir -p $script_dir/home

# Get current user and group IDs
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

# Get docker group ID from host system
export DOCKER_GID=$(grep "^docker:x:" /etc/group | cut -d: -f3 2>/dev/null || echo "")

# If docker group doesn't exist, use default GID 999
if [ -z "$DOCKER_GID" ]; then
    export DOCKER_GID=10000
fi

echo "Building with USER_ID=$USER_ID, GROUP_ID=$GROUP_ID, DOCKER_GID=$DOCKER_GID"

# Build using docker compose
COMPOSE_BAKE=true docker compose build

echo "Build completed!"
popd
