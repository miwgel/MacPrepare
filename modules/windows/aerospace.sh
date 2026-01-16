#!/bin/bash
# modules/windows/aerospace.sh - Instalar AeroSpace

install_aerospace() {
    echo "  Instalando AeroSpace..."

    if app_installed "AeroSpace"; then
        echo "  AeroSpace ya esta instalado"
        return 0
    fi

    brew install --cask aerospace

    echo "  AeroSpace instalado"

    return 0
}

install_aerospace
