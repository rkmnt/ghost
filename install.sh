#!/bin/bash

INSTALL_DIR="$HOME/.local/bin/ghost"
SCRIPT_NAME="ghost"
MIN_SPACE_MB=100

OS=$(uname -s)
if [[ "$OS" != "Darwin" ]]; then
    echo "❌ Unsupported OS: $OS. This script only supports macOS."
    exit 1
fi

ARCH=$(uname -m)
if [[ "$ARCH" != "x86_64" && "$ARCH" != "arm64" ]]; then
    echo "❌ Unsupported architecture: $ARCH. Ghost only supports x86_64 and ARM64."
    exit 1
fi

if ! command -v pwsh &> /dev/null; then
    echo "❌ PowerShell (pwsh) is not installed."
    read -p "Would you like to install it? (Y/N): " install_pwsh
    if [[ "$install_pwsh" =~ ^[Yy]$ ]]; then
        if ! command -v brew &> /dev/null; then
            echo "❌ Homebrew is not installed. Install Homebrew first: https://brew.sh"
            exit 1
        fi
        brew install --cask powershell || { echo "❌ Installation failed!"; exit 1; }
        echo "✅ PowerShell installed successfully!"
    else
        echo "❌ Installation canceled."
        exit 1
    fi
fi

AVAILABLE_SPACE_MB=$(df "$HOME" | awk 'NR==2 {printf "%.0f", $4 / 1024}')
if (( AVAILABLE_SPACE_MB < MIN_SPACE_MB )); then
    echo "❌ Not enough disk space! Required: ${MIN_SPACE_MB}MB, Available: ${AVAILABLE_SPACE_MB}MB."
    exit 1
fi

REQUIRED_TOOLS=("curl" "git")
for TOOL in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v $TOOL &> /dev/null; then
        echo "❌ Missing required tool: '$TOOL'."
        read -p "Would you like to install it? (Y/N): " install_tool
        if [[ "$install_tool" =~ ^[Yy]$ ]]; then
            brew install $TOOL || { echo "❌ Installation failed!"; exit 1; }
        else
            echo "❌ Installation canceled."
            exit 1
        fi
    fi
done

if [[ -e "$INSTALL_DIR" && ! -d "$INSTALL_DIR" ]]; then
    echo "⚠️ Removing existing file $INSTALL_DIR"
    rm -f "$INSTALL_DIR"
fi

if [[ -d "$INSTALL_DIR" ]]; then
    read -p "⚠️ Ghost is already installed. Do you want to remove the old version? (Y/N): " remove_old
    if [[ "$remove_old" =~ ^[Yy]$ ]]; then
        rm -rf "$INSTALL_DIR"
        echo "✅ Old version removed."
    else
        echo "❌ Installation canceled."
        exit 1
    fi
fi

echo "🔄 Installing Ghost..."
mkdir -p "$INSTALL_DIR"
cp -r scripts modules ghost.ps1 README.md "$INSTALL_DIR/"

WRAPPER_SCRIPT="$HOME/.local/bin/$SCRIPT_NAME"
echo "#!/bin/bash" > "$WRAPPER_SCRIPT"
echo "pwsh $INSTALL_DIR/ghost.ps1 \"\$@\"" >> "$WRAPPER_SCRIPT"
chmod +x "$WRAPPER_SCRIPT"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
    echo "export PATH=\"$HOME/.local/bin:\$PATH\"" >> "$SHELL_CONFIG"
    echo "✅ Added $HOME/.local/bin to PATH. Restart your terminal or run: source $SHELL_CONFIG"
fi

echo "✅ Ghost installed successfully!"
echo "🔥 You can now run 'ghost' from anywhere!"
