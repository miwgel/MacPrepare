#!/bin/bash
# modules/development/bruno.sh - Install Bruno

install_bruno() {
    echo "  Installing Bruno..."

    if app_installed "Bruno"; then
        echo "  Bruno is already installed"
        return 0
    fi

    brew install --cask bruno || return 1
    echo "  Bruno installed"

    return 0
}

install_bruno
