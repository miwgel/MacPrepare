#!/bin/bash
# modules/vms/parallels.sh - Instalar Parallels

install_parallels() {
    echo "  Instalando Parallels..."

    if app_installed "Parallels Desktop"; then
        echo "  Parallels ya esta instalado"
        return 0
    fi

    brew install --cask parallels

    echo "  Parallels instalado"

    return 0
}

install_parallels
