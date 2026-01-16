#!/bin/bash
# modules/design/figma.sh - Instalar Figma

install_figma() {
    echo "  Instalando Figma..."

    if app_installed "Figma"; then
        echo "  Figma ya esta instalado"
        return 0
    fi

    brew install --cask figma

    echo "  Figma instalado"

    return 0
}

install_figma
