#!/bin/bash
# modules/terminals/alacritty.sh - Install Alacritty

install_alacritty() {
    echo "  Installing Alacritty..."

    if app_installed "Alacritty"; then
        echo "  Alacritty is already installed"
        return 0
    fi

    brew install --cask alacritty || return 1
    echo "  Alacritty installed"

    return 0
}

install_alacritty
