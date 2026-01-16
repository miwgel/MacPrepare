#!/bin/bash
# modules/automation/hammerspoon.sh - Instalar Hammerspoon

install_hammerspoon() {
    echo "  Instalando Hammerspoon..."

    if app_installed "Hammerspoon"; then
        echo "  Hammerspoon ya esta instalado"
        return 0
    fi

    brew install --cask hammerspoon

    echo "  Hammerspoon instalado"

    return 0
}

install_hammerspoon
