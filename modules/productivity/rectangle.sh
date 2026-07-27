#!/bin/bash
# modules/productivity/rectangle.sh - Install Rectangle

install_rectangle() {
    echo "  Installing Rectangle..."

    if app_installed "Rectangle"; then
        echo "  Rectangle is already installed"
        return 0
    fi

    brew install --cask rectangle || return 1
    echo "  Rectangle installed"

    return 0
}

install_rectangle
