#!/bin/bash
# modules/development/orbstack.sh - Install OrbStack

install_orbstack() {
    echo "  Installing OrbStack..."

    if app_installed "OrbStack"; then
        echo "  OrbStack is already installed"
        return 0
    fi

    brew install --cask orbstack || return 1
    echo "  OrbStack installed"

    return 0
}

install_orbstack
