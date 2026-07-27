#!/bin/bash
# modules/windows/dockdoor.sh - Install DockDoor

install_dockdoor() {
    echo "  Installing DockDoor..."

    if app_installed "DockDoor"; then
        echo "  DockDoor is already installed"
        return 0
    fi

    brew install --cask dockdoor || return 1
    echo "  DockDoor installed"

    return 0
}

install_dockdoor
