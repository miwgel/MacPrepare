#!/bin/bash
# modules/utilities/betterdisplay.sh - Install BetterDisplay

install_betterdisplay() {
    echo "  Installing BetterDisplay..."

    if app_installed "BetterDisplay"; then
        echo "  BetterDisplay is already installed"
        return 0
    fi

    brew install --cask betterdisplay || return 1
    echo "  BetterDisplay installed"

    return 0
}

install_betterdisplay
