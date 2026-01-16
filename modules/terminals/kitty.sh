#!/bin/bash
# modules/terminals/kitty.sh - Instalar Kitty

install_kitty() {
    echo "  Instalando Kitty..."

    if app_installed "kitty"; then
        echo "  Kitty ya esta instalado"
        return 0
    fi

    brew install --cask kitty

    echo "  Kitty instalado"

    return 0
}

install_kitty
