# CLAUDE.md
USE "docker compose", never use "docker-compose" command

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Docker-based environment for running Claude Code. The setup consists of:

- **Dockerfile**: Alpine Linux container with Claude Code CLI pre-installed
- **docker-compose.yml**: Service configuration with dynamic user ID mapping
- **claude-run.sh**: Shell script that launches Claude Code in a Docker container with current directory mounted
- **build.sh**: Build script that detects host user parameters and builds the container accordingly

## Container Environment

- Base image: Alpine Linux
- User ID: Dynamic (matches host user via build arguments)
- Working directory: Current directory (mounted dynamically)
- Home directory: `/home/claude-code` (persistent volume in `./home`)
- Package manager: npm (Node.js environment)
- Docker access: Container has access to host Docker daemon via socket mount

## Installation

1. First build the container using the build script:
```bash
./build.sh
```

The build script automatically:
- Detects current user ID and group ID
- Detects Docker group ID from host system
- Exports these as environment variables for docker compose build
- Builds the container with proper user mapping

2. Install the command globally (optional):
```bash
./install.sh
```

The install script:
- First runs build script automatically
- Creates `~/bin` directory if it doesn't exist
- Creates a symlink `~/bin/claude` pointing to `claude-run.sh`
- Checks if `~/bin` is in PATH and provides instructions if not

## Running Commands

To execute Claude Code:
```bash
./claude-run.sh [arguments]
```

The script automatically:
- Mounts the current directory to the same path in the container
- Sets the working directory to the current directory
- Runs as the current host user (via dynamic user mapping)
- Provides access to Docker daemon for container operations

## Development Environment

The container includes:
- bash, curl, nodejs, npm, openssh, coreutils, docker, docker-compose
- Claude Code CLI (`@anthropic-ai/claude-code`)
- Docker daemon access for container operations
- User runs with same UID/GID as host user for seamless file permissions

Work is done in the dynamically mounted current directory, maintaining proper file ownership and permissions.