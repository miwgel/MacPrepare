#!/bin/bash
# modules/windows/dockdoor.sh - Instalar DockDoor

install_dockdoor() {
    echo "  Instalando DockDoor..."

    if app_installed "DockDoor"; then
        echo "  DockDoor ya esta instalado"
        return 0
    fi

    brew install --cask dockdoor

    echo "  DockDoor instalado"

    return 0
}

install_dockdoor
