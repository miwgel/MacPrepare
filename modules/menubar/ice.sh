#!/bin/bash
# modules/menubar/ice.sh - Instalar Ice

install_ice() {
    echo "  Instalando Ice..."

    if app_installed "Ice"; then
        echo "  Ice ya esta instalado"
        return 0
    fi

    brew install --cask ice

    echo "  Ice instalado"

    return 0
}

install_ice
