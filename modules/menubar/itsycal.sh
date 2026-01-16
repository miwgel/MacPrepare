#!/bin/bash
# modules/menubar/itsycal.sh - Instalar Itsycal

install_itsycal() {
    echo "  Instalando Itsycal..."

    if app_installed "Itsycal"; then
        echo "  Itsycal ya esta instalado"
        return 0
    fi

    brew install --cask itsycal

    echo "  Itsycal instalado"

    return 0
}

install_itsycal
