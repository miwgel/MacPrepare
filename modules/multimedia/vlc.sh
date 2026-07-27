#!/bin/bash
# modules/multimedia/vlc.sh - Install VLC

install_vlc() {
    echo "  Installing VLC..."

    if app_installed "VLC"; then
        echo "  VLC is already installed"
        return 0
    fi

    brew install --cask vlc || return 1
    echo "  VLC installed"

    return 0
}

install_vlc
