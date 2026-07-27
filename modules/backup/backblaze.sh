#!/bin/bash
# modules/backup/backblaze.sh - Install Backblaze

install_backblaze() {
    echo "  Installing Backblaze..."

    if app_installed "Backblaze"; then
        echo "  Backblaze is already installed"
        return 0
    fi

    brew install --cask backblaze || return 1
    echo "  Backblaze installed"

    return 0
}

install_backblaze
