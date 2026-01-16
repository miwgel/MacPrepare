#!/bin/bash
# modules/browsers/arc.sh - Instalar Arc

install_arc() {
    echo "  Instalando Arc..."

    if app_installed "Arc"; then
        echo "  Arc ya esta instalado"
        return 0
    fi

    brew install --cask arc

    echo "  Arc instalado"

    return 0
}

install_arc
