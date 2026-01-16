#!/bin/bash
# modules/development/platypus.sh - Instalar Platypus

install_platypus() {
    echo "  Instalando Platypus..."

    if app_installed "Platypus"; then
        echo "  Platypus ya esta instalado"
        return 0
    fi

    brew install --cask platypus

    echo "  Platypus instalado"

    return 0
}

install_platypus
