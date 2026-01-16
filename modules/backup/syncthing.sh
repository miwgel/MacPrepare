#!/bin/bash
# modules/backup/syncthing.sh - Instalar Syncthing

install_syncthing() {
    echo "  Instalando Syncthing..."

    if app_installed "Syncthing"; then
        echo "  Syncthing ya esta instalado"
        return 0
    fi

    brew install --cask syncthing

    echo "  Syncthing instalado"

    return 0
}

install_syncthing
