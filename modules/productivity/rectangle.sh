#!/bin/bash
# modules/productivity/rectangle.sh - Instalar Rectangle

install_rectangle() {
    echo "  Instalando Rectangle..."

    if app_installed "Rectangle"; then
        echo "  Rectangle ya esta instalado"
        return 0
    fi

    brew install --cask rectangle

    echo "  Rectangle instalado"

    return 0
}

install_rectangle
