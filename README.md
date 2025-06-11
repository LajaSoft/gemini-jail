# Claude Code Docker Environment



A containerized environment for running Claude Code CLI in Docker with proper file permissions and Docker socket access.

<img src="picture.jpg" alt="Claude Code Docker Environment Logo" width=100em />

## Purpose

This project solves file permission and Docker socket access issues when using Claude Code in a container. The container automatically configures itself for the current system user, enabling:

- Run Claude Code in an isolated environment
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

After installation, the `claude` command will be available from any directory.

## Usage

### Direct execution:
```bash
./claude-run.sh [Claude Code arguments]
```

### After installation:
```bash
claude [Claude Code arguments]
```

### Examples:
```bash
# Start Claude Code
claude

# Start with specific model
claude --model sonnet
```

look at claude --help for more info 

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
- **Path-related options**: Some Claude Code options related to paths may not work properly in the containerized environment