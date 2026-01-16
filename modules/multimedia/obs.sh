#!/bin/bash
# modules/multimedia/obs.sh - Instalar OBS Studio

install_obs() {
    echo "  Instalando OBS Studio..."

    if app_installed "OBS"; then
        echo "  OBS ya esta instalado"
        return 0
    fi

    brew install --cask obs

    echo "  OBS Studio instalado"

    return 0
}

install_obs
