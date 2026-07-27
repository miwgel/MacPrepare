#!/bin/bash
# modules/utilities/keepingyouawake.sh - Install KeepingYouAwake

install_keepingyouawake() {
    echo "  Installing KeepingYouAwake..."

    if app_installed "KeepingYouAwake"; then
        echo "  KeepingYouAwake is already installed"
        return 0
    fi

    brew install --cask keepingyouawake || return 1
    echo "  KeepingYouAwake installed"

    return 0
}

install_keepingyouawake
