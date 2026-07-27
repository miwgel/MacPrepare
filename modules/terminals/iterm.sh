#!/bin/bash
# modules/terminals/iterm.sh - Install iTerm2

install_iterm() {
    echo "  Installing iTerm2..."

    if app_installed "iTerm"; then
        echo "  iTerm2 is already installed"
        return 0
    fi

    brew install --cask iterm2 || return 1
    echo "  iTerm2 installed"

    return 0
}

install_iterm
