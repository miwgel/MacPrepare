#!/bin/bash
# modules/browsers/arc.sh - Install Arc

install_arc() {
    echo "  Installing Arc..."

    if app_installed "Arc"; then
        echo "  Arc is already installed"
        return 0
    fi

    brew install --cask arc || return 1
    echo "  Arc installed"

    return 0
}

install_arc
