#!/bin/bash
# modules/keyboard/cheatsheet.sh - Install CheatSheet

install_cheatsheet() {
    echo "  Installing CheatSheet..."

    if app_installed "CheatSheet"; then
        echo "  CheatSheet is already installed"
        return 0
    fi

    brew install --cask cheatsheet || return 1
    echo "  CheatSheet installed"

    return 0
}

install_cheatsheet
