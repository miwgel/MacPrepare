#!/bin/bash
# modules/design/blender.sh - Instalar Blender

install_blender() {
    echo "  Instalando Blender..."

    if app_installed "Blender"; then
        echo "  Blender ya esta instalado"
        return 0
    fi

    brew install --cask blender

    echo "  Blender instalado"

    return 0
}

install_blender
