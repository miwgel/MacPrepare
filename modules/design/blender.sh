#!/bin/bash
# modules/design/blender.sh - Install Blender

install_blender() {
    echo "  Installing Blender..."

    if app_installed "Blender"; then
        echo "  Blender is already installed"
        return 0
    fi

    brew install --cask blender || return 1
    echo "  Blender installed"

    return 0
}

install_blender
