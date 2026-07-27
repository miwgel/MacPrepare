#!/bin/bash
# modules/browsers/helium.sh - Install Helium

install_helium() {
    echo "  Installing Helium..."

    if app_installed "Helium"; then
        echo "  Helium is already installed"
        return 0
    fi

    brew install --cask helium-browser || return 1

    echo "  Helium installed"

    return 0
}

install_helium
