#!/bin/bash
# modules/communication/thunderbird.sh - Install Thunderbird

install_thunderbird() {
    echo "  Installing Thunderbird..."

    if app_installed "Thunderbird"; then
        echo "  Thunderbird is already installed"
        return 0
    fi

    brew install --cask thunderbird || return 1
    echo "  Thunderbird installed"

    return 0
}

install_thunderbird
