#!/bin/bash
# modules/input/mos.sh - Install Mos

install_mos() {
    echo "  Installing Mos..."

    if app_installed "Mos"; then
        echo "  Mos is already installed"
        return 0
    fi

    brew install --cask mos || return 1
    echo "  Mos installed"

    return 0
}

install_mos
