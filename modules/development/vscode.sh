#!/bin/bash
# modules/development/vscode.sh - Instalar Visual Studio Code

install_vscode() {
    echo "  Instalando Visual Studio Code..."

    if app_installed "Visual Studio Code"; then
        echo "  VS Code ya esta instalado"
        return 0
    fi

    brew install --cask visual-studio-code

    echo "  Visual Studio Code instalado"

    return 0
}

install_vscode
