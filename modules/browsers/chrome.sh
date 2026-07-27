#!/bin/bash
# modules/browsers/chrome.sh - Install Google Chrome

install_chrome() {
    echo "  Installing Google Chrome..."

    if app_installed "Google Chrome"; then
        echo "  Google Chrome is already installed"
        return 0
    fi

    brew install --cask google-chrome || return 1
    echo "  Google Chrome installed"

    return 0
}

install_chrome
