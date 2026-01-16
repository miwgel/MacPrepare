#!/bin/bash
# modules/browsers/zen.sh - Instalar Zen Browser

install_zen() {
    echo "  Instalando Zen Browser..."

    if app_installed "Zen Browser"; then
        echo "  Zen Browser ya esta instalado"
        return 0
    fi

    # Zen Browser esta disponible via Homebrew cask
    brew install --cask zen-browser

    echo "  Zen Browser instalado"

    return 0
}

install_zen
