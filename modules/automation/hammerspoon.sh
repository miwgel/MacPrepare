#!/bin/bash
# modules/automation/hammerspoon.sh - Install Hammerspoon

install_hammerspoon() {
    echo "  Installing Hammerspoon..."

    if app_installed "Hammerspoon"; then
        echo "  Hammerspoon is already installed"
        return 0
    fi

    brew install --cask hammerspoon || return 1
    echo "  Hammerspoon installed"

    return 0
}

install_hammerspoon
