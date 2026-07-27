#!/bin/bash
# modules/keyboard/espanso.sh - Install Espanso

install_espanso() {
    echo "  Installing Espanso..."

    if app_installed "Espanso"; then
        echo "  Espanso is already installed"
        return 0
    fi

    brew install --cask espanso || return 1
    echo "  Espanso installed"

    return 0
}

install_espanso
