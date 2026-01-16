#!/bin/bash
# modules/input/mos.sh - Instalar Mos

install_mos() {
    echo "  Instalando Mos..."

    if app_installed "Mos"; then
        echo "  Mos ya esta instalado"
        return 0
    fi

    brew install --cask mos

    echo "  Mos instalado"

    return 0
}

install_mos
