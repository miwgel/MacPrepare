#!/bin/bash
# modules/gaming/steam.sh - Instalar Steam

install_steam() {
    echo "  Instalando Steam..."

    if app_installed "Steam"; then
        echo "  Steam ya esta instalado"
        return 0
    fi

    brew install --cask steam

    echo "  Steam instalado"

    return 0
}

install_steam
