#!/bin/bash
# modules/design/figma.sh - Install Figma

install_figma() {
    echo "  Installing Figma..."

    if app_installed "Figma"; then
        echo "  Figma is already installed"
        return 0
    fi

    brew install --cask figma || return 1
    echo "  Figma installed"

    return 0
}

install_figma
