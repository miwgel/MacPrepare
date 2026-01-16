#!/bin/bash
# modules/notes/obsidian.sh - Instalar Obsidian

install_obsidian() {
    echo "  Instalando Obsidian..."

    if app_installed "Obsidian"; then
        echo "  Obsidian ya esta instalado"
        return 0
    fi

    brew install --cask obsidian

    echo "  Obsidian instalado"

    return 0
}

install_obsidian
