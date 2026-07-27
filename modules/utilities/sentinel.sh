#!/bin/bash
# modules/utilities/sentinel.sh - Install Sentinel

install_sentinel() {
    echo "  Installing Sentinel..."

    if app_installed "Sentinel"; then
        echo "  Sentinel is already installed"
        return 0
    fi

    brew install --cask alienator88-sentinel || return 1
    echo "  Sentinel installed"

    return 0
}

install_sentinel
