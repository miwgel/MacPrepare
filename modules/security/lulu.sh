#!/bin/bash
# modules/security/lulu.sh - Instalar LuLu

install_lulu() {
    echo "  Instalando LuLu..."

    if app_installed "LuLu"; then
        echo "  LuLu ya esta instalado"
        return 0
    fi

    brew install --cask lulu

    echo "  LuLu instalado"

    return 0
}

install_lulu
