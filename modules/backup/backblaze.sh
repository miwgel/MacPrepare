#!/bin/bash
# modules/backup/backblaze.sh - Instalar Backblaze

install_backblaze() {
    echo "  Instalando Backblaze..."

    if app_installed "Backblaze"; then
        echo "  Backblaze ya esta instalado"
        return 0
    fi

    brew install --cask backblaze

    echo "  Backblaze instalado"

    return 0
}

install_backblaze
