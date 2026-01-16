#!/bin/bash
# modules/utilities/keka.sh - Instalar Keka

install_keka() {
    echo "  Instalando Keka..."

    if app_installed "Keka"; then
        echo "  Keka ya esta instalado"
        return 0
    fi

    brew install --cask keka

    echo "  Keka instalado"

    return 0
}

install_keka
