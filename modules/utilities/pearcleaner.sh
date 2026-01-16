#!/bin/bash
# modules/utilities/pearcleaner.sh - Instalar PearCleaner

install_pearcleaner() {
    echo "  Instalando PearCleaner..."

    if app_installed "PearCleaner"; then
        echo "  PearCleaner ya esta instalado"
        return 0
    fi

    brew install --cask pearcleaner

    echo "  PearCleaner instalado"

    return 0
}

install_pearcleaner
