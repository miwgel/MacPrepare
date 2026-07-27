#!/bin/bash
# modules/security/1password.sh - Install 1Password

install_1password() {
    echo "  Installing 1Password..."

    if app_installed "1Password"; then
        echo "  1Password is already installed"
        return 0
    fi

    brew install --cask 1password || return 1
    echo "  1Password installed"

    return 0
}

install_1password
