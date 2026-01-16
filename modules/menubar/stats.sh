#!/bin/bash
# modules/menubar/stats.sh - Instalar Stats

install_stats() {
    echo "  Instalando Stats..."

    if app_installed "Stats"; then
        echo "  Stats ya esta instalado"
        return 0
    fi

    brew install --cask stats

    echo "  Stats instalado"

    return 0
}

install_stats
