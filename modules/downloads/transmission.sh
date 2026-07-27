#!/bin/bash
# modules/downloads/transmission.sh - Install Transmission

install_transmission() {
    echo "  Installing Transmission..."

    if app_installed "Transmission"; then
        echo "  Transmission is already installed"
        return 0
    fi

    brew install --cask transmission || return 1
    echo "  Transmission installed"

    return 0
}

install_transmission
