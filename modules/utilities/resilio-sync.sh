#!/bin/bash
# modules/utilities/resilio-sync.sh - Install Resilio Sync

install_resilio() {
    echo "  Installing Resilio Sync..."

    if app_installed "Resilio Sync"; then
        echo "  Resilio Sync is already installed"
        return 0
    fi

    brew install --cask resilio-sync || return 1
    echo "  Resilio Sync installed"

    return 0
}

install_resilio
