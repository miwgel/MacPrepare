#!/bin/bash
# modules/productivity/maccy.sh - Install Maccy

install_maccy() {
    echo "  Installing Maccy..."

    if app_installed "Maccy"; then
        echo "  Maccy is already installed"
        return 0
    fi

    brew install --cask maccy || return 1
    echo "  Maccy installed"

    return 0
}

install_maccy
