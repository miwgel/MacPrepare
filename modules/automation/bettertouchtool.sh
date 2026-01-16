#!/bin/bash
# modules/automation/bettertouchtool.sh - Instalar BetterTouchTool

install_bettertouchtool() {
    echo "  Instalando BetterTouchTool..."

    if app_installed "BetterTouchTool"; then
        echo "  BetterTouchTool ya esta instalado"
        return 0
    fi

    brew install --cask bettertouchtool

    echo "  BetterTouchTool instalado"

    return 0
}

install_bettertouchtool
