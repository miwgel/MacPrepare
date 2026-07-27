#!/bin/bash
# modules/communication/discord.sh - Install Discord

install_discord() {
    echo "  Installing Discord..."

    if app_installed "Discord"; then
        echo "  Discord is already installed"
        return 0
    fi

    brew install --cask discord || return 1
    echo "  Discord installed"

    return 0
}

install_discord
