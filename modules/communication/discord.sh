#!/bin/bash
# modules/communication/discord.sh - Instalar Discord

install_discord() {
    echo "  Instalando Discord..."

    if app_installed "Discord"; then
        echo "  Discord ya esta instalado"
        return 0
    fi

    brew install --cask discord

    echo "  Discord instalado"

    return 0
}

install_discord
