#!/bin/bash
# modules/security/lulu.sh - Install LuLu

install_lulu() {
    echo "  Installing LuLu..."

    if app_installed "LuLu"; then
        echo "  LuLu is already installed"
        return 0
    fi

    brew install --cask lulu || return 1
    echo "  LuLu installed"

    return 0
}

install_lulu
