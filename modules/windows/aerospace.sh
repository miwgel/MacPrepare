#!/bin/bash
# modules/windows/aerospace.sh - Install AeroSpace

install_aerospace() {
    echo "  Installing AeroSpace..."

    if app_installed "AeroSpace"; then
        echo "  AeroSpace is already installed"
        return 0
    fi

    brew install --cask nikitabobko/tap/aerospace || return 1
    echo "  AeroSpace installed"

    return 0
}

install_aerospace
