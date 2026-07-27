#!/bin/bash
# modules/windows/alttab.sh - Install AltTab

install_alttab() {
    echo "  Installing AltTab..."

    if app_installed "AltTab"; then
        echo "  AltTab is already installed"
        return 0
    fi

    brew install --cask alt-tab || return 1
    echo "  AltTab installed"

    return 0
}

install_alttab
