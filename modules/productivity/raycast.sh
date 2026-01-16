#!/bin/bash
# modules/productivity/raycast.sh - Instalar Raycast

install_raycast() {
    echo "  Instalando Raycast..."

    if app_installed "Raycast"; then
        echo "  Raycast ya esta instalado"
        return 0
    fi

    brew install --cask raycast

    echo "  Raycast instalado"

    return 0
}

install_raycast
