#!/bin/bash
# modules/multimedia/kap.sh - Install Kap

install_kap() {
    echo "  Installing Kap..."

    if app_installed "Kap"; then
        echo "  Kap is already installed"
        return 0
    fi

    brew install --cask kap || return 1
    echo "  Kap installed"

    return 0
}

install_kap
