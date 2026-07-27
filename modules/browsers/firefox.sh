#!/bin/bash
# modules/browsers/firefox.sh - Install Firefox

install_firefox() {
    echo "  Installing Firefox..."

    if app_installed "Firefox"; then
        echo "  Firefox is already installed"
        return 0
    fi

    brew install --cask firefox || return 1
    echo "  Firefox installed"

    return 0
}

install_firefox
