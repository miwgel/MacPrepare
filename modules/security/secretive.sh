#!/bin/bash
# modules/security/secretive.sh - Instalar Secretive

install_secretive() {
    echo "  Instalando Secretive..."

    if app_installed "Secretive"; then
        echo "  Secretive ya esta instalado"
        return 0
    fi

    brew install --cask secretive

    echo "  Secretive instalado"

    return 0
}

install_secretive
