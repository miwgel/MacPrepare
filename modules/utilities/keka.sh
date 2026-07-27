#!/bin/bash
# modules/utilities/keka.sh - Install Keka

install_keka() {
    echo "  Installing Keka..."

    if app_installed "Keka"; then
        echo "  Keka is already installed"
        return 0
    fi

    brew install --cask keka || return 1
    echo "  Keka installed"

    return 0
}

install_keka
