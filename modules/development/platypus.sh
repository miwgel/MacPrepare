#!/bin/bash
# modules/development/platypus.sh - Install Platypus

install_platypus() {
    echo "  Installing Platypus..."

    if app_installed "Platypus"; then
        echo "  Platypus is already installed"
        return 0
    fi

    brew install --cask platypus || return 1
    echo "  Platypus installed"

    return 0
}

install_platypus
