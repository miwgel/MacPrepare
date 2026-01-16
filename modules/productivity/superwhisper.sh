#!/bin/bash
# modules/productivity/superwhisper.sh - Instalar Superwhisper

install_superwhisper() {
    echo "  Instalando Superwhisper..."

    if app_installed "Superwhisper"; then
        echo "  Superwhisper ya esta instalado"
        return 0
    fi

    brew install --cask superwhisper

    echo "  Superwhisper instalado"

    return 0
}

install_superwhisper
