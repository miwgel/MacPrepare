#!/bin/bash
# modules/keyboard/karabiner.sh - Install Karabiner-Elements

install_karabiner() {
    echo "  Installing Karabiner-Elements..."

    if app_installed "Karabiner-Elements"; then
        echo "  Karabiner-Elements is already installed"
        return 0
    fi

    brew install --cask karabiner-elements || return 1
    echo "  Karabiner-Elements installed"

    return 0
}

install_karabiner
