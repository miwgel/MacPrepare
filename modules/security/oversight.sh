#!/bin/bash
# modules/security/oversight.sh - Install Oversight

install_oversight() {
    echo "  Installing Oversight..."

    if app_installed "OverSight"; then
        echo "  Oversight is already installed"
        return 0
    fi

    brew install --cask oversight || return 1
    echo "  Oversight installed"

    return 0
}

install_oversight
