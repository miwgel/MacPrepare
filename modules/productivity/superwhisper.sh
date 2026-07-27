#!/bin/bash
# modules/productivity/superwhisper.sh - Install Superwhisper

install_superwhisper() {
    echo "  Installing Superwhisper..."

    if app_installed "Superwhisper"; then
        echo "  Superwhisper is already installed"
        return 0
    fi

    brew install --cask superwhisper || return 1
    echo "  Superwhisper installed"

    return 0
}

install_superwhisper
