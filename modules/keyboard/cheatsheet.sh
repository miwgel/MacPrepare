#!/bin/bash
# modules/keyboard/cheatsheet.sh - Instalar CheatSheet

install_cheatsheet() {
    echo "  Instalando CheatSheet..."

    if app_installed "CheatSheet"; then
        echo "  CheatSheet ya esta instalado"
        return 0
    fi

    brew install --cask cheatsheet

    echo "  CheatSheet instalado"

    return 0
}

install_cheatsheet
