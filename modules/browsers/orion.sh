#!/bin/bash
# modules/browsers/orion.sh - Install Orion

install_orion() {
    echo "  Installing Orion..."

    if app_installed "Orion"; then
        echo "  Orion is already installed"
        return 0
    fi

    brew install --cask orion || return 1
    echo "  Orion installed"

    return 0
}

install_orion
