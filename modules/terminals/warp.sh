#!/bin/bash
# modules/terminals/warp.sh - Instalar Warp

install_warp() {
    echo "  Instalando Warp..."

    if app_installed "Warp"; then
        echo "  Warp ya esta instalado"
        return 0
    fi

    brew install --cask warp

    echo "  Warp instalado"

    return 0
}

install_warp
