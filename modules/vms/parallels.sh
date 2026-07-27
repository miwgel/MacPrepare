#!/bin/bash
# modules/vms/parallels.sh - Install Parallels

install_parallels() {
    echo "  Installing Parallels..."

    if app_installed "Parallels Desktop"; then
        echo "  Parallels is already installed"
        return 0
    fi

    brew install --cask parallels || return 1
    echo "  Parallels installed"

    return 0
}

install_parallels
