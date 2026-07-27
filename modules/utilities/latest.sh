#!/bin/bash
# modules/utilities/latest.sh - Install Latest

install_latest() {
    echo "  Installing Latest..."

    if app_installed "Latest"; then
        echo "  Latest is already installed"
        return 0
    fi

    brew install --cask latest || return 1
    echo "  Latest installed"

    return 0
}

install_latest
