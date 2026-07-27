#!/bin/bash
# modules/terminals/ghostty.sh - Install Ghostty

install_ghostty() {
    echo "  Installing Ghostty..."

    if app_installed "Ghostty"; then
        echo "  Ghostty is already installed"
        return 0
    fi

    brew install --cask ghostty || return 1
    echo "  Ghostty installed"

    return 0
}

install_ghostty
