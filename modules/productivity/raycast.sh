#!/bin/bash
# modules/productivity/raycast.sh - Install Raycast

install_raycast() {
    echo "  Installing Raycast..."

    if app_installed "Raycast"; then
        echo "  Raycast is already installed"
        return 0
    fi

    brew install --cask raycast || return 1
    echo "  Raycast installed"

    return 0
}

install_raycast
