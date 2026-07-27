#!/bin/bash
# modules/productivity/shottr.sh - Install Shottr

install_shottr() {
    echo "  Installing Shottr..."

    if app_installed "Shottr"; then
        echo "  Shottr is already installed"
        return 0
    fi

    brew install --cask shottr || return 1
    echo "  Shottr installed"

    return 0
}

install_shottr
