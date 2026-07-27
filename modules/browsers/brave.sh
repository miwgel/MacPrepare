#!/bin/bash
# modules/browsers/brave.sh - Install Brave

install_brave() {
    echo "  Installing Brave..."

    if app_installed "Brave Browser"; then
        echo "  Brave is already installed"
        return 0
    fi

    brew install --cask brave-browser || return 1
    echo "  Brave installed"

    return 0
}

install_brave
