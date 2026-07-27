#!/bin/bash
# modules/gaming/steam.sh - Install Steam

install_steam() {
    echo "  Installing Steam..."

    if app_installed "Steam"; then
        echo "  Steam is already installed"
        return 0
    fi

    brew install --cask steam || return 1
    echo "  Steam installed"

    return 0
}

install_steam
