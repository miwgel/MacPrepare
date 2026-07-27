#!/bin/bash
# modules/notes/obsidian.sh - Install Obsidian

install_obsidian() {
    echo "  Installing Obsidian..."

    if app_installed "Obsidian"; then
        echo "  Obsidian is already installed"
        return 0
    fi

    brew install --cask obsidian || return 1
    echo "  Obsidian installed"

    return 0
}

install_obsidian
