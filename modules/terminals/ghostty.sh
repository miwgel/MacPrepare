#!/bin/bash
# modules/terminals/ghostty.sh - Instalar Ghostty

install_ghostty() {
    echo "  Instalando Ghostty..."

    if app_installed "Ghostty"; then
        echo "  Ghostty ya esta instalado"
        return 0
    fi

    brew install --cask ghostty

    echo "  Ghostty instalado"

    return 0
}

install_ghostty
