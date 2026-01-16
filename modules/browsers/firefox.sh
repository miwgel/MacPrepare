#!/bin/bash
# modules/browsers/firefox.sh - Instalar Firefox

install_firefox() {
    echo "  Instalando Firefox..."

    if app_installed "Firefox"; then
        echo "  Firefox ya esta instalado"
        return 0
    fi

    brew install --cask firefox

    echo "  Firefox instalado"

    return 0
}

install_firefox
