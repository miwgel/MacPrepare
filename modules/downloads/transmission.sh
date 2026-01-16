#!/bin/bash
# modules/downloads/transmission.sh - Instalar Transmission

install_transmission() {
    echo "  Instalando Transmission..."

    if app_installed "Transmission"; then
        echo "  Transmission ya esta instalado"
        return 0
    fi

    brew install --cask transmission

    echo "  Transmission instalado"

    return 0
}

install_transmission
