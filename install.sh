#!/bin/bash

# Install script for Gemini Cli Docker wrapper
# Creates symlink to gemini-run.sh in ~/bin/gemini and ensures ~/bin is in PATH

set -e

SCRIPT_DIR=$(dirname $(realpath $0))
BIN_DIR="$HOME/bin"
SYMLINK_PATH="$BIN_DIR/gemini"
pushd .
cd $SCRIPT_DIR
./build.sh
popd

echo "Installing Gemini Cli Docker wrapper..."

# Create ~/bin directory if it doesn't exist
if [ ! -d "$BIN_DIR" ]; then
    echo "Creating $BIN_DIR directory..."
    mkdir -p "$BIN_DIR"
fi

# Create symlink to gemini-run.sh
echo "Creating symlink $SYMLINK_PATH -> $SCRIPT_DIR/gemini-run.sh"
ln -sf "$SCRIPT_DIR/gemini-run.sh" "$SYMLINK_PATH"

# Make sure gemini-run.sh is executable
chmod +x "$SCRIPT_DIR/gemini-run.sh"

# Check if ~/bin is in PATH
if echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "✓ $BIN_DIR is already in PATH"
    echo "✓ Installation complete! You can now use 'gemini' command from anywhere."
else
    echo "⚠️  $BIN_DIR is not in your PATH"
    echo ""
    echo "To use the 'gemini' command from anywhere, add the following line to your shell configuration:"
    echo ""
    
    # Detect shell and provide appropriate instructions
    if [ -n "$BASH_VERSION" ]; then
        echo "For bash, add to ~/.bashrc:"
        echo "export PATH=\"\$HOME/bin:\$PATH\""
        echo ""
        echo "Then run: source ~/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        echo "For zsh, add to ~/.zshrc:"
        echo "export PATH=\"\$HOME/bin:\$PATH\""
        echo ""
        echo "Then run: source ~/.zshrc"
    else
        echo "Add to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):"
        echo "export PATH=\"\$HOME/bin:\$PATH\""
        echo ""
        echo "Then restart your shell or source the configuration file"
    fi
    
    echo ""
    echo "Alternatively, you can run the command directly: $SYMLINK_PATH"
fi

echo ""
echo "Installation completed!"