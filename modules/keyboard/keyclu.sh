#!/bin/bash
# modules/keyboard/keyclu.sh - Install KeyClu

install_keyclu() {
    echo "  Installing KeyClu..."

    if app_installed "KeyClu"; then
        echo "  KeyClu is already installed"
        return 0
    fi

    brew install --cask keyclu || return 1
    echo "  KeyClu installed"

    return 0
}

install_keyclu
