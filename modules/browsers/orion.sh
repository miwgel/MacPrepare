#!/bin/bash
# modules/browsers/orion.sh - Instalar Orion

install_orion() {
    echo "  Instalando Orion..."

    if app_installed "Orion"; then
        echo "  Orion ya esta instalado"
        return 0
    fi

    brew install --cask orion

    echo "  Orion instalado"

    return 0
}

install_orion
