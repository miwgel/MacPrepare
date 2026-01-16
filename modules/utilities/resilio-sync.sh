#!/bin/bash
# modules/utilities/resilio-sync.sh - Instalar Resilio Sync

install_resilio() {
    echo "  Instalando Resilio Sync..."

    if app_installed "Resilio Sync"; then
        echo "  Resilio Sync ya esta instalado"
        return 0
    fi

    brew install --cask resilio-sync

    echo "  Resilio Sync instalado"

    return 0
}

install_resilio
