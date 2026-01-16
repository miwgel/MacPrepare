#!/bin/bash
# modules/multimedia/vlc.sh - Instalar VLC

install_vlc() {
    echo "  Instalando VLC..."

    if app_installed "VLC"; then
        echo "  VLC ya esta instalado"
        return 0
    fi

    brew install --cask vlc

    echo "  VLC instalado"

    return 0
}

install_vlc
