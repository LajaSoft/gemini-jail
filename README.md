# Gemini Cli Docker Environment



A containerized environment for running Gemini Cli CLI in Docker with proper file permissions and Docker socket access.

<img src="picture.jpg" alt="Gemini Cli Docker Environment Logo" width=100em />

## Purpose

This project solves file permission and Docker socket access issues when using Gemini Cli in a container. The container automatically configures itself for the current system user, enabling:

- Run Gemini Cli in an isolated environment
- Work with files without permission issues
- Use Docker from within the container (Docker-in-Docker)
- Persist home directory between runs


## Installation

1. Build the container:
```bash
./build.sh
```

2. (Optional) Install global command:
```bash
./install.sh
```

After installation, the `gemini` command will be available from any directory.

## Usage

### Direct execution:
```bash
./gemini-run.sh [Gemini Cli arguments]
```

### After installation:
```bash
gemini [Gemini Cli arguments]
```

### Examples:
```bash
# Start Gemini Cli
gemini

# Start with specific model
gemini --model sonnet
```

look at gemini --help for more info 

some options realated to paths can not work in container

## Features

- Automatic detection of current user UID/GID
- Current directory mounted into container
- Access to host Docker socket
- Persistent home directory in `./home`
- Runs as host user (not root)

## Limitations

- **VSCode Integration**: Currently doesn't work with VSCode IDE integration. If you know how to fix this, please share your solution!
- **Container Isolation**: Not 100% secure isolation since the container has access to Docker daemon. A sophisticated AI agent could potentially escape the container
- **Path-related options**: Some Gemini Cli options related to paths may not work properly in the containerized environment