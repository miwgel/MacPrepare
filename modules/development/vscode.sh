#!/bin/bash
# modules/development/vscode.sh - Install Visual Studio Code

install_vscode() {
    echo "  Installing Visual Studio Code..."

    if app_installed "Visual Studio Code"; then
        echo "  VS Code is already installed"
        return 0
    fi

    brew install --cask visual-studio-code || return 1
    echo "  Visual Studio Code installed"

    return 0
}

install_vscode
