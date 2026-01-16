#!/bin/bash
# modules/utilities/sentinel.sh - Instalar Sentinel

install_sentinel() {
    echo "  Instalando Sentinel..."

    if app_installed "Sentinel"; then
        echo "  Sentinel ya esta instalado"
        return 0
    fi

    brew install --cask sentinel

    echo "  Sentinel instalado"

    return 0
}

install_sentinel
