#!/bin/bash
# modules/backup/syncthing.sh - Install Syncthing

install_syncthing() {
    echo "  Installing Syncthing..."

    if app_installed "Syncthing"; then
        echo "  Syncthing is already installed"
        return 0
    fi

    brew install --cask syncthing || return 1
    echo "  Syncthing installed"

    return 0
}

install_syncthing
