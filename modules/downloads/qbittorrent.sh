#!/bin/bash
# modules/downloads/qbittorrent.sh - Instalar qBittorrent

install_qbittorrent() {
    echo "  Instalando qBittorrent..."

    if app_installed "qBittorrent"; then
        echo "  qBittorrent ya esta instalado"
        return 0
    fi

    brew install --cask qbittorrent

    echo "  qBittorrent instalado"

    return 0
}

install_qbittorrent
