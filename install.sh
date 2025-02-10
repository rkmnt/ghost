#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="ghost"

if [[ ! -f "o365-ghost.ps1" ]]; then
    echo "Error: File 'o365-ghost.ps1' not found!"
    exit 1
fi

echo "Installing ghost..."

mkdir -p "$INSTALL_DIR"


cp "o365-ghost.ps1" "$INSTALL_DIR/$SCRIPT_NAME"


chmod +x "$INSTALL_DIR/$SCRIPT_NAME"


if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.zshrc"
    echo "Added $INSTALL_DIR to PATH. Restart terminal or run: source ~/.zshrc"
fi

echo "Ghost was successfully installed!"
echo "You can now run 'ghost' from anywhere using 'pwsh ghost'."
