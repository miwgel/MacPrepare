#!/bin/bash
# modules/terminals/warp.sh - Install Warp

install_warp() {
    echo "  Installing Warp..."

    if app_installed "Warp"; then
        echo "  Warp is already installed"
        return 0
    fi

    brew install --cask warp || return 1
    echo "  Warp installed"

    return 0
}

install_warp
