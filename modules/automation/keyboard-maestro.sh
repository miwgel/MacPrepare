#!/bin/bash
# modules/automation/keyboard-maestro.sh - Install Keyboard Maestro

install_keyboard_maestro() {
    echo "  Installing Keyboard Maestro..."

    if app_installed "Keyboard Maestro"; then
        echo "  Keyboard Maestro is already installed"
        return 0
    fi

    brew install --cask keyboard-maestro || return 1
    echo "  Keyboard Maestro installed"

    return 0
}

install_keyboard_maestro
