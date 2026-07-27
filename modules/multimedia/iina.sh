#!/bin/bash
# modules/multimedia/iina.sh - Install IINA

install_iina() {
    echo "  Installing IINA..."

    if app_installed "IINA"; then
        echo "  IINA is already installed"
        return 0
    fi

    brew install --cask iina || return 1
    echo "  IINA installed"

    return 0
}

install_iina
