#!/bin/bash
# modules/security/secretive.sh - Install Secretive

install_secretive() {
    echo "  Installing Secretive..."

    if app_installed "Secretive"; then
        echo "  Secretive is already installed"
        return 0
    fi

    brew install --cask secretive || return 1
    echo "  Secretive installed"

    return 0
}

install_secretive
