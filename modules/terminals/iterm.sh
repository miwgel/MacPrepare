#!/bin/bash
# modules/terminals/iterm.sh - Instalar iTerm2

install_iterm() {
    echo "  Instalando iTerm2..."

    if app_installed "iTerm"; then
        echo "  iTerm2 ya esta instalado"
        return 0
    fi

    brew install --cask iterm2

    echo "  iTerm2 instalado"

    return 0
}

install_iterm
