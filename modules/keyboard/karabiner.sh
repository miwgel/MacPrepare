#!/bin/bash
# modules/keyboard/karabiner.sh - Instalar Karabiner-Elements

install_karabiner() {
    echo "  Instalando Karabiner-Elements..."

    if app_installed "Karabiner-Elements"; then
        echo "  Karabiner-Elements ya esta instalado"
        return 0
    fi

    brew install --cask karabiner-elements

    echo "  Karabiner-Elements instalado"

    return 0
}

install_karabiner
