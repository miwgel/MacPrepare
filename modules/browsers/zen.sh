#!/bin/bash
# modules/browsers/zen.sh - Install Zen Browser

install_zen() {
    echo "  Installing Zen Browser..."

    if app_installed "Zen"; then
        echo "  Zen Browser is already installed"
        return 0
    fi

    # Zen Browser esta disponible via Homebrew cask
    brew install --cask zen-browser || return 1
    echo "  Zen Browser installed"

    return 0
}

install_zen
