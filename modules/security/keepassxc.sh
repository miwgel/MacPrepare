#!/bin/bash
# modules/security/keepassxc.sh - Install KeePassXC

install_keepassxc() {
    echo "  Installing KeePassXC..."

    if app_installed "KeePassXC"; then
        echo "  KeePassXC is already installed"
        return 0
    fi

    brew install --cask keepassxc || return 1
    echo "  KeePassXC installed"

    return 0
}

install_keepassxc
