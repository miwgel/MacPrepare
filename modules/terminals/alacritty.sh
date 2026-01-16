#!/bin/bash
# modules/terminals/alacritty.sh - Instalar Alacritty

install_alacritty() {
    echo "  Instalando Alacritty..."

    if app_installed "Alacritty"; then
        echo "  Alacritty ya esta instalado"
        return 0
    fi

    brew install --cask alacritty

    echo "  Alacritty instalado"

    return 0
}

install_alacritty
