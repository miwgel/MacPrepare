#!/bin/bash
# modules/input/linearmouse.sh - Install LinearMouse

install_linearmouse() {
    echo "  Installing LinearMouse..."

    if app_installed "LinearMouse"; then
        echo "  LinearMouse is already installed"
        return 0
    fi

    brew install --cask linearmouse || return 1
    echo "  LinearMouse installed"

    return 0
}

install_linearmouse
