#!/bin/bash
# modules/utilities/grandperspective.sh - Instalar GrandPerspective

install_grandperspective() {
    echo "  Instalando GrandPerspective..."

    if app_installed "GrandPerspective"; then
        echo "  GrandPerspective ya esta instalado"
        return 0
    fi

    brew install --cask grandperspective

    echo "  GrandPerspective instalado"

    return 0
}

install_grandperspective
