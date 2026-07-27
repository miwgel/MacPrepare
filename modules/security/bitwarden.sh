#!/bin/bash
# modules/security/bitwarden.sh - Install Bitwarden

install_bitwarden() {
    echo "  Installing Bitwarden..."

    if app_installed "Bitwarden"; then
        echo "  Bitwarden is already installed"
        return 0
    fi

    brew install --cask bitwarden || return 1
    echo "  Bitwarden installed"

    return 0
}

install_bitwarden
