#!/bin/bash
# modules/downloads/qbittorrent.sh - Install qBittorrent

install_qbittorrent() {
    echo "  Installing qBittorrent..."

    if app_installed "qBittorrent"; then
        echo "  qBittorrent is already installed"
        return 0
    fi

    brew install --cask qbittorrent || return 1
    echo "  qBittorrent installed"

    return 0
}

install_qbittorrent
