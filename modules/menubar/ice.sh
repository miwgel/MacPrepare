#!/bin/bash
# modules/menubar/ice.sh - Install Ice

install_ice() {
    echo "  Installing Ice..."

    if app_installed "Ice"; then
        echo "  Ice is already installed"
        return 0
    fi

    brew install --cask jordanbaird-ice || return 1
    echo "  Ice installed"

    return 0
}

install_ice
