#!/bin/bash
# modules/terminals/kitty.sh - Install Kitty

install_kitty() {
    echo "  Installing Kitty..."

    if app_installed "kitty"; then
        echo "  Kitty is already installed"
        return 0
    fi

    brew install --cask kitty || return 1
    echo "  Kitty installed"

    return 0
}

install_kitty
