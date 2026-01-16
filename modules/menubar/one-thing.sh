#!/bin/bash
# modules/menubar/one-thing.sh - Instalar One Thing

install_one_thing() {
    echo "  Instalando One Thing..."

    if app_installed "One Thing"; then
        echo "  One Thing ya esta instalado"
        return 0
    fi

    brew install --cask one-thing

    echo "  One Thing instalado"

    return 0
}

install_one_thing
