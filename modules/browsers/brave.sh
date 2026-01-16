#!/bin/bash
# modules/browsers/brave.sh - Instalar Brave

install_brave() {
    echo "  Instalando Brave..."

    if app_installed "Brave Browser"; then
        echo "  Brave ya esta instalado"
        return 0
    fi

    brew install --cask brave-browser

    echo "  Brave instalado"

    return 0
}

install_brave
