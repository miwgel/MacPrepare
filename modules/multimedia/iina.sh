#!/bin/bash
# modules/multimedia/iina.sh - Instalar IINA

install_iina() {
    echo "  Instalando IINA..."

    if app_installed "IINA"; then
        echo "  IINA ya esta instalado"
        return 0
    fi

    brew install --cask iina

    echo "  IINA instalado"

    return 0
}

install_iina
